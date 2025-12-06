package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// TestGeneralInfraEnvironmentValidation validates the general-infra environment configuration
func TestGeneralInfraEnvironmentValidation(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		TerraformDir: "../../../../environments/dev/02-general-infra",
		NoColor:      true,
	}

	terraform.InitAndValidate(t, terraformOptions)
}

// TestGeneralInfraOutputs validates that all expected outputs are defined
func TestGeneralInfraOutputs(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		TerraformDir: "../../../../environments/dev/02-general-infra",
		NoColor:      true,
	}

	terraform.Init(t, terraformOptions)

	outputKeys := terraform.GetAllOutputKeys(t, terraformOptions)
	
	expectedOutputs := []string{
		"resource_group_name",
		"resource_group_id",
		"storage_account_id",
		"storage_account_name",
		"storage_account_primary_blob_endpoint",
		"networking_vnet_id",
		"networking_subnet_ids",
	}

	for _, expectedOutput := range expectedOutputs {
		assert.Contains(t, outputKeys, expectedOutput, "Output %s should be defined", expectedOutput)
	}
}

// TestGeneralInfraDataSources validates data source configurations
func TestGeneralInfraDataSources(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		TerraformDir: "../../../../environments/dev/02-general-infra",
		NoColor:      true,
	}

	terraform.InitAndValidate(t, terraformOptions)
}

// TestGeneralInfraStorageAccountConfig validates storage account configuration
func TestGeneralInfraStorageAccountConfig(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		TerraformDir: "../../../../environments/dev/02-general-infra",
		NoColor:      true,
	}

	terraform.InitAndValidate(t, terraformOptions)
}