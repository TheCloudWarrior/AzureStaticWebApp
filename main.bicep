param resourceLocation string
param resourceGroupName string
param webAppName string
param customDomainName string
param dnsResourceGroup string

targetScope = 'subscription'

resource resourceGroup 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: resourceGroupName
  location: resourceLocation
}

module webApp '_modules/webapp/main.bicep' = {
  name: 'staticwebapp'
  scope: resourceGroup
  params: {
    webAppName: webAppName
    resourceLocation: resourceLocation
    customDomainName: customDomainName
    dnsResourceGroup: dnsResourceGroup
  }
}


