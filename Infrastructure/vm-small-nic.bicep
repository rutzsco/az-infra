param namePrefix string = 'unique'
param location string = resourceGroup().location
param subnetId string
param privateIPAddress string =  '10.0.0.4'

var vmName = '${namePrefix}${uniqueString(resourceGroup().id)}'
var pipName = '${vmName}-pip'

resource pip 'Microsoft.Network/publicIPAddresses@2020-08-01' = {
  name: pipName
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
    publicIPAddressVersion: 'IPv4'
    idleTimeoutInMinutes: 4
  }
  zones: [
    '1'
  ]
}

resource nic_vm 'Microsoft.Network/networkInterfaces@2020-08-01' = {
  name: vmName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: subnetId
          }
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: pip.id
          }
        }
      }
    ]
  }
}


output nicId string = nic_vm.id
