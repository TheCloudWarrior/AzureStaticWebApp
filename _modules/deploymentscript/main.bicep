param resourceLocation string = 'westeurope'
param now string = utcNow('F')
param staticSiteName string
param customDomainName string
param identityPrincipalId string

resource deploymentScript 'Microsoft.Resources/deploymentScripts@2023-08-01' = {
  name: 'deploymentScript'
  kind: 'AzurePowerShell'
  location: resourceLocation
  properties: {
    azPowerShellVersion: '3.0'
    scriptContent: loadTextContent('./_scripts/Test-Resource.ps1')
    arguments: '-subscriptionId ${subscription().id} -resourceGroup ${resourceGroup().name} -staticSiteName ${staticSiteName} -customDomainName ${customDomainName}'
    retentionInterval: 'P1D'
    cleanupPreference: 'Always'
    forceUpdateTag: now
    timeout: 'PT5M'
  }
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${identityPrincipalId}': {}
    }
  }
}

output validationToken string = deploymentScript.properties.outputs.validationToken
