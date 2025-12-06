package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

// TestFullStackDeployment tests the complete deployment pipeline
func TestFullStackDeployment(t *testing.T) {
	t.Run("Stage1_Networking", func(t *testing.T) {
		terraformOptions := &terraform.Options{
			TerraformDir: "../../environments/dev/01-networking",
			NoColor:      true,
		}

		terraform.InitAndValidate(t, terraformOptions)
	})

	t.Run("Stage2_GeneralInfra", func(t *testing.T) {
		terraformOptions := &terraform.Options{
			TerraformDir: "../../environments/dev/02-general-infra",
			NoColor:      true,
		}

		terraform.InitAndValidate(t, terraformOptions)
	})

	t.Run("Stage3_Applications", func(t *testing.T) {
		terraformOptions := &terraform.Options{
			TerraformDir: "../../environments/dev/03-applications",
			NoColor:      true,
		}

		terraform.InitAndValidate(t, terraformOptions)
	})
}

// TestStateFileConfiguration validates backend configuration across all stages
func TestStateFileConfiguration(t *testing.T) {
	stages := []struct {
		name         string
		dir          string
		expectedKey  string
	}{
		{
			name:        "Networking",
			dir:         "../../environments/dev/01-networking",
			expectedKey: "dev-01-networking.tfstate",
		},
		{
			name:        "GeneralInfra",
			dir:         "../../environments/dev/02-general-infra",
			expectedKey: "dev-02-general-infra.tfstate",
		},
		{
			name:        "Applications",
			dir:         "../../environments/dev/03-applications",
			expectedKey: "dev-03-applications.tfstate",
		},
	}

	for _, stage := range stages {
		t.Run(stage.name, func(t *testing.T) {
			terraformOptions := &terraform.Options{
				TerraformDir: stage.dir,
				NoColor:      true,
			}

			terraform.InitAndValidate(t, terraformOptions)
		})
	}
}