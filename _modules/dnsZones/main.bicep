param dnsZoneName string
param endpointId string = ''
param validationToken string = ''

resource dnsZone 'Microsoft.Network/dnsZones@2023-07-01-preview' existing = {
  name: dnsZoneName
}

resource endpointDNS 'Microsoft.Network/dnsZones/A@2018-05-01' = if (endpointId != '') {
  name: '@'
  parent: dnsZone
  properties: {
    TTL: 1
    targetResource: {
      id: endpointId
    }
  }
}

resource txtRecord 'Microsoft.Network/dnsZones/TXT@2018-05-01' = if (validationToken != '') {
  name: '@'
  parent: dnsZone
  properties: {
    TTL: 1
    TXTRecords: [
      {
        value: [ validationToken ]
      }
    ]
  }
}
