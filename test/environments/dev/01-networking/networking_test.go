package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// TestNetworkingEnvironmentValidation validates the networking environment configuration
func TestNetworkingEnvironmentValidation(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		TerraformDir: "../../../../environments/dev/01-networking",
		NoColor:      true,
	}

	terraform.InitAndValidate(t, terraformOptions)
}

// TestNetworkingOutputs validates that all expected outputs are defined
func TestNetworkingOutputs(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		TerraformDir: "../../../../environments/dev/01-networking",
		NoColor:      true,
	}

	terraform.Init(t, terraformOptions)

	outputKeys := terraform.GetAllOutputKeys(t, terraformOptions)
	
	expectedOutputs := []string{
		"resource_group_name",
		"resource_group_id",
		"vnet_id",
		"vnet_name",
		"subnet_ids",
		"subnet_names",
		"nsg_ids",
		"nsg_names",
	}

	for _, expectedOutput := range expectedOutputs {
		assert.Contains(t, outputKeys, expectedOutput, "Output %s should be defined", expectedOutput)
	}
}

// TestNetworkingNSGRules validates NSG rule configurations
func TestNetworkingNSGRules(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		TerraformDir: "../../../../environments/dev/01-networking",
		NoColor:      true,
	}

	terraform.InitAndValidate(t, terraformOptions)
}

// TestNetworkingSubnetDelegations validates subnet delegation configurations
func TestNetworkingSubnetDelegations(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		TerraformDir: "../../../../environments/dev/01-networking",
		NoColor:      true,
	}

	terraform.InitAndValidate(t, terraformOptions)
}