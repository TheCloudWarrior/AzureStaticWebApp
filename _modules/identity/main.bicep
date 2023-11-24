param resourceLocation string = 'westeurope'

resource identity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: 'uai-deployment-static'
  location: resourceLocation
}

// Assign the identity the "Reader" role on the resource group
resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid('acdd72a7-3385-48ef-bd42-f606fba81ae7', identity.name, subscription().subscriptionId, resourceGroup().name)
  properties: {
    principalId: identity.properties.principalId
    roleDefinitionId: resourceId('Microsoft.Authorization/roleDefinitions', 'acdd72a7-3385-48ef-bd42-f606fba81ae7')
    principalType: 'ServicePrincipal'
  }
}

output identityPrincipalId string = identity.id
