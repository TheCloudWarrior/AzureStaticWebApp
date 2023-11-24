param (
    [string]$subscriptionId,    
    [string]$resourceGroupName,
    [string]$staticSiteName,
    [string]$customDomainName
)

$validationToken = ((Invoke-AzRestMethod -Uri "https://management.azure.com/subscriptions/$($subscriptionId)/resourceGroups/$($resourceGroupName)/providers/Microsoft.Web/staticSites/$($staticSiteName)/customDomains/$($customDomainName)?api-version=2020-12-01").content | ConvertFrom-Json -Depth 99).properties.validationToken

$DeploymentScriptOutputs = @{}
$DeploymentScriptOutputs['validationToken'] = $validationToken
