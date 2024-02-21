#!/usr/bin/python3

import boto3
import os

frequency = os.environ["CONFIG_RECORDER_FREQUENCY"]
continuous_regions = os.environ["CONFIG_CONTINUOUS_REGIONS"].split(",")
retention = int(os.getenv("CONFIG_RECORDER_RETENTION", "0"))
role_arn = os.environ["TF_AWS_ROLE"]
target_regions = os.environ["CONFIG_REGIONS"].split(",")

# assume terraform role
sts_client = boto3.client("sts")
print(f"Assuming AWS role {role_arn}")
assumed = sts_client.assume_role(
    RoleArn=role_arn,
    RoleSessionName="TerragruntConfigurationRecorderProvisioner",
)["Credentials"]

for region in target_regions:
    # setup AWS Config connection
    config = boto3.client(
        "config",
        aws_access_key_id=assumed["AccessKeyId"],
        aws_secret_access_key=assumed["SecretAccessKey"],
        aws_session_token=assumed["SessionToken"],
        region_name=region,
    )

    recorder = config.describe_configuration_recorders()["ConfigurationRecorders"][0]
    recordingMode = recorder.get("recordingMode", {})

    if (
        frequency == "CONTINUOUS"
        and continuous_regions
        and region not in continuous_regions
    ):
        frequency = "DAILY"

    if recordingMode.get("recordingFrequency") != frequency:
        print(f"Setting {region} Config recorder frequency to {frequency}")
        recordingMode["recordingFrequency"] = frequency
        recorder["recordingMode"] = recordingMode
        config.put_configuration_recorder(ConfigurationRecorder=recorder)

    if retention:
        current_retention = config.describe_retention_configurations()[
            "RetentionConfigurations"
        ]
        if current_retention != [
            {"Name": recorder["name"], "RetentionPeriodInDays": retention}
        ]:
            print(f"Setting {region} Config retention to {retention} days")
            config.put_retention_configuration(RetentionPeriodInDays=retention)
