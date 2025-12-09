package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// TestApplicationsEnvironmentValidation validates the applications environment configuration
func TestApplicationsEnvironmentValidation(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		TerraformDir: "../../../../environments/dev/03-applications",
		NoColor:      true,
	}

	terraform.InitAndValidate(t, terraformOptions)
}

// TestApplicationsOutputs validates that all expected outputs are defined
func TestApplicationsOutputs(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		TerraformDir: "../../../../environments/dev/03-applications",
		NoColor:      true,
	}

	terraform.Init(t, terraformOptions)

	outputKeys := terraform.GetAllOutputKeys(t, terraformOptions)
	
	expectedOutputs := []string{
		"resource_group_name",
		"resource_group_id",
		"app_service_plan_id",
		"app_service_plan_name",
		"logic_app_id",
		"logic_app_name",
	}

	for _, expectedOutput := range expectedOutputs {
		assert.Contains(t, outputKeys, expectedOutput, "Output %s should be defined", expectedOutput)
	}
}

// TestApplicationsDataSources validates data source configurations
func TestApplicationsDataSources(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		TerraformDir: "../../../../environments/dev/03-applications",
		NoColor:      true,
	}

	terraform.InitAndValidate(t, terraformOptions)
}

// TestApplicationsLogicAppIntegration validates Logic App configuration
func TestApplicationsLogicAppIntegration(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		TerraformDir: "../../../../environments/dev/03-applications",
		NoColor:      true,
	}

	terraform.InitAndValidate(t, terraformOptions)
}