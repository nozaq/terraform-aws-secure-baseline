#!/usr/bin/python3

import boto3
import os
import sys

retention = int(os.getenv("CONFIG_RECORDER_RETENTION", "0"))
role_arn = os.environ["TF_AWS_ROLE"]
target_regions = os.environ["CONFIG_REGIONS"].split(",")

if not retention:
  print("No retention config, nothing to do, bye.")
  sys.exit(0)

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

    current_retention = config.describe_retention_configurations()[
        "RetentionConfigurations"
    ]
    if current_retention != [
        {"Name": recorder["name"], "RetentionPeriodInDays": retention}
    ]:
        print(f"Setting {region} Config retention to {retention} days")
        config.put_retention_configuration(RetentionPeriodInDays=retention)
