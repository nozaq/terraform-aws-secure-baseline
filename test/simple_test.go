package test

import (
	"testing"

	"github.com/google/uuid"
	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestSimpleExampleApply(t *testing.T) {
	bucketName := uuid.NewString()
	awsRegion := aws.GetRandomStableRegion(t, nil, nil)

	registryTerraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../examples/simple",
		Vars: map[string]interface{}{
			"audit_s3_bucket_name": bucketName,
			"region":               awsRegion,
		},
		NoColor: true,
	})
	defer terraform.Destroy(t, registryTerraformOptions)

	terraform.InitAndApply(t, registryTerraformOptions)
}

func TestDiffFromMaster(t *testing.T) {
	bucketName := uuid.NewString()
	awsRegion := aws.GetRandomStableRegion(t, nil, nil)

	registryTerraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "./fixtures/simple_registry",
		Vars: map[string]interface{}{
			"audit_s3_bucket_name": bucketName,
			"region":               awsRegion,
		},
		NoColor: true,
	})
	defer terraform.Destroy(t, registryTerraformOptions)

	terraform.InitAndApply(t, registryTerraformOptions)

	localTerraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "./fixtures/simple_local",
		Vars: map[string]interface{}{
			"audit_s3_bucket_name": bucketName,
			"region":               awsRegion,
		},
		NoColor:      true,
		MigrateState: true,
	})
	planResult := terraform.InitAndPlan(t, localTerraformOptions)

	t.Log(planResult)
}
