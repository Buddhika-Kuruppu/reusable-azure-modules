package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// TestLogicAppStandardModule tests the logic-app-standard module
func TestLogicAppStandardModule(t *testing.T) {
	t.Parallel()

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../../modules/logic-app-standard",
		Vars: map[string]interface{}{
			"name":                       "test-logic-app",
			"resource_group_name":        "test-rg",
			"location":                   "eastus",
			"app_service_plan_id":        "/subscriptions/test-sub/resourceGroups/test-rg/providers/Microsoft.Web/serverfarms/test-asp",
			"storage_account_name":       "teststorageacct",
			"storage_account_access_key": "test-key-value",
		},
		NoColor: true,
	})

	defer terraform.Destroy(t, terraformOptions)

	// Validate Terraform code
	terraform.InitAndValidate(t, terraformOptions)
}

// TestLogicAppStandardWithOptionalParameters tests the module with optional parameters
func TestLogicAppStandardWithOptionalParameters(t *testing.T) {
	t.Parallel()

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../../modules/logic-app-standard",
		Vars: map[string]interface{}{
			"name":                       "test-logic-app-full",
			"resource_group_name":        "test-rg",
			"location":                   "eastus",
			"app_service_plan_id":        "/subscriptions/test-sub/resourceGroups/test-rg/providers/Microsoft.Web/serverfarms/test-asp",
			"storage_account_name":       "teststorageacct",
			"storage_account_access_key": "test-key-value",
			"app_settings": map[string]interface{}{
				"FUNCTIONS_WORKER_RUNTIME":     "node",
				"WEBSITE_NODE_DEFAULT_VERSION": "~14",
			},
			"enabled":    true,
			"https_only": true,
			"version":    "~4",
			"tags": map[string]interface{}{
				"Environment": "Test",
				"ManagedBy":   "Terratest",
			},
		},
		NoColor: true,
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndValidate(t, terraformOptions)
}

// TestLogicAppStandardWithSiteConfig tests the module with site_config
func TestLogicAppStandardWithSiteConfig(t *testing.T) {
	t.Parallel()

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../../modules/logic-app-standard",
		Vars: map[string]interface{}{
			"name":                       "test-logic-app-siteconfig",
			"resource_group_name":        "test-rg",
			"location":                   "eastus",
			"app_service_plan_id":        "/subscriptions/test-sub/resourceGroups/test-rg/providers/Microsoft.Web/serverfarms/test-asp",
			"storage_account_name":       "teststorageacct",
			"storage_account_access_key": "test-key-value",
			"site_config": map[string]interface{}{
				"always_on":                   true,
				"ftps_state":                  "Disabled",
				"http2_enabled":               true,
				"min_tls_version":             "1.2",
				"websockets_enabled":          false,
				"use_32_bit_worker_process":   false,
			},
		},
		NoColor: true,
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndValidate(t, terraformOptions)
}

// TestLogicAppStandardWithIdentity tests the module with managed identity
func TestLogicAppStandardWithIdentity(t *testing.T) {
	t.Parallel()

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../../modules/logic-app-standard",
		Vars: map[string]interface{}{
			"name":                       "test-logic-app-identity",
			"resource_group_name":        "test-rg",
			"location":                   "eastus",
			"app_service_plan_id":        "/subscriptions/test-sub/resourceGroups/test-rg/providers/Microsoft.Web/serverfarms/test-asp",
			"storage_account_name":       "teststorageacct",
			"storage_account_access_key": "test-key-value",
			"identity": map[string]interface{}{
				"type": "SystemAssigned",
			},
		},
		NoColor: true,
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndValidate(t, terraformOptions)
}

// TestLogicAppStandardWithVnetIntegration tests the module with VNet integration
func TestLogicAppStandardWithVnetIntegration(t *testing.T) {
	t.Parallel()

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../../modules/logic-app-standard",
		Vars: map[string]interface{}{
			"name":                       "test-logic-app-vnet",
			"resource_group_name":        "test-rg",
			"location":                   "eastus",
			"app_service_plan_id":        "/subscriptions/test-sub/resourceGroups/test-rg/providers/Microsoft.Web/serverfarms/test-asp",
			"storage_account_name":       "teststorageacct",
			"storage_account_access_key": "test-key-value",
			"virtual_network_subnet_id":  "/subscriptions/test-sub/resourceGroups/test-rg/providers/Microsoft.Network/virtualNetworks/test-vnet/subnets/test-subnet",
			"site_config": map[string]interface{}{
				"vnet_route_all_enabled": true,
			},
		},
		NoColor: true,
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndValidate(t, terraformOptions)
}

// TestLogicAppStandardWithConnectionStrings tests the module with connection strings
func TestLogicAppStandardWithConnectionStrings(t *testing.T) {
	t.Parallel()

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../../modules/logic-app-standard",
		Vars: map[string]interface{}{
			"name":                       "test-logic-app-connstr",
			"resource_group_name":        "test-rg",
			"location":                   "eastus",
			"app_service_plan_id":        "/subscriptions/test-sub/resourceGroups/test-rg/providers/Microsoft.Web/serverfarms/test-asp",
			"storage_account_name":       "teststorageacct",
			"storage_account_access_key": "test-key-value",
			"connection_strings": []interface{}{
				map[string]interface{}{
					"name":  "Database",
					"type":  "SQLAzure",
					"value": "Server=tcp:test.database.windows.net,1433;Database=testdb;",
				},
			},
		},
		NoColor: true,
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndValidate(t, terraformOptions)
}

// TestLogicAppStandardDisabled tests the module with enabled=false
func TestLogicAppStandardDisabled(t *testing.T) {
	t.Parallel()

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../../modules/logic-app-standard",
		Vars: map[string]interface{}{
			"name":                       "test-logic-app-disabled",
			"resource_group_name":        "test-rg",
			"location":                   "eastus",
			"app_service_plan_id":        "/subscriptions/test-sub/resourceGroups/test-rg/providers/Microsoft.Web/serverfarms/test-asp",
			"storage_account_name":       "teststorageacct",
			"storage_account_access_key": "test-key-value",
			"enabled":                    false,
		},
		NoColor: true,
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndValidate(t, terraformOptions)
}

// TestLogicAppStandardHTTPOnlyDisabled tests the module with https_only=false
func TestLogicAppStandardHTTPOnlyDisabled(t *testing.T) {
	t.Parallel()

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../../modules/logic-app-standard",
		Vars: map[string]interface{}{
			"name":                       "test-logic-app-http",
			"resource_group_name":        "test-rg",
			"location":                   "eastus",
			"app_service_plan_id":        "/subscriptions/test-sub/resourceGroups/test-rg/providers/Microsoft.Web/serverfarms/test-asp",
			"storage_account_name":       "teststorageacct",
			"storage_account_access_key": "test-key-value",
			"https_only":                 false,
		},
		NoColor: true,
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndValidate(t, terraformOptions)
}

// TestLogicAppStandardClientCertificateMode tests different client certificate modes
func TestLogicAppStandardClientCertificateMode(t *testing.T) {
	testCases := []struct {
		name string
		mode string
	}{
		{"Required", "Required"},
		{"Optional", "Optional"},
		{"OptionalInteractiveUser", "OptionalInteractiveUser"},
	}

	for _, tc := range testCases {
		tc := tc
		t.Run(tc.name, func(t *testing.T) {
			t.Parallel()

			terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
				TerraformDir: "../../../modules/logic-app-standard",
				Vars: map[string]interface{}{
					"name":                       "test-logic-app-cert-" + tc.name,
					"resource_group_name":        "test-rg",
					"location":                   "eastus",
					"app_service_plan_id":        "/subscriptions/test-sub/resourceGroups/test-rg/providers/Microsoft.Web/serverfarms/test-asp",
					"storage_account_name":       "teststorageacct",
					"storage_account_access_key": "test-key-value",
					"client_certificate_mode":    tc.mode,
				},
				NoColor: true,
			})

			defer terraform.Destroy(t, terraformOptions)

			terraform.InitAndValidate(t, terraformOptions)
		})
	}
}

// TestLogicAppStandardWithIPRestrictions tests the module with IP restrictions
func TestLogicAppStandardWithIPRestrictions(t *testing.T) {
	t.Parallel()

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../../modules/logic-app-standard",
		Vars: map[string]interface{}{
			"name":                       "test-logic-app-iprestrict",
			"resource_group_name":        "test-rg",
			"location":                   "eastus",
			"app_service_plan_id":        "/subscriptions/test-sub/resourceGroups/test-rg/providers/Microsoft.Web/serverfarms/test-asp",
			"storage_account_name":       "teststorageacct",
			"storage_account_access_key": "test-key-value",
			"site_config": map[string]interface{}{
				"ip_restriction": []interface{}{
					map[string]interface{}{
						"ip_address": "192.168.1.0/24",
						"name":       "AllowOfficeNetwork",
						"priority":   100,
						"action":     "Allow",
					},
				},
			},
		},
		NoColor: true,
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndValidate(t, terraformOptions)
}

// TestLogicAppStandardVariableValidation tests variable validations
func TestLogicAppStandardVariableValidation(t *testing.T) {
	t.Run("InvalidClientCertificateMode", func(t *testing.T) {
		terraformOptions := &terraform.Options{
			TerraformDir: "../../../modules/logic-app-standard",
			Vars: map[string]interface{}{
				"name":                       "test-logic-app",
				"resource_group_name":        "test-rg",
				"location":                   "eastus",
				"app_service_plan_id":        "/subscriptions/test-sub/resourceGroups/test-rg/providers/Microsoft.Web/serverfarms/test-asp",
				"storage_account_name":       "teststorageacct",
				"storage_account_access_key": "test-key-value",
				"client_certificate_mode":    "InvalidMode",
			},
			NoColor: true,
		}

		_, err := terraform.InitAndPlanE(t, terraformOptions)
		assert.Error(t, err, "Should fail with invalid client_certificate_mode")
	})
}