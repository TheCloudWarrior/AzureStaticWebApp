param resourceLocation string = 'westeurope'
param webAppName string
param customDomainName string

param dnsResourceGroup string

resource webApp 'Microsoft.Web/staticSites@2022-09-01' = {
  name: webAppName
  location: resourceLocation
  sku: {
    name: 'Free'
  }
  properties: {
  }
}

resource webAppCustomDomain 'Microsoft.Web/staticSites/customDomains@2022-09-01' = {
  name: customDomainName
  parent: webApp
  properties: {
    validationMethod: 'dns-txt-token'
  }
}

module dnsZones '../dnsZones/main.bicep' = {
  scope: resourceGroup(dnsResourceGroup)
  name: 'dnsZonesA'
  params: {
    dnsZoneName: customDomainName
    endpointId: webApp.id
    validationToken: ''
  }
}

module identity '../identity/main.bicep' = {
  name: 'identity'
  params: {
    resourceLocation: resourceLocation
  }
}

module getToken '../deploymentscript/main.bicep' = {
  name: 'getToken'
  params: {
    customDomainName: customDomainName
    staticSiteName: webApp.name
    resourceLocation: resourceLocation
    identityPrincipalId: identity.outputs.identityPrincipalId
  }  
}

module dnsZonesTXT '../dnsZones/main.bicep' = {
  scope: resourceGroup('dnszones')
  name: 'dnsZonesTXT'
  params: {
    dnsZoneName: customDomainName
    endpointId: ''
    validationToken: getToken.outputs.validationToken
  }
}
