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
    name: 'Basic'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
    publicIPAddressVersion: 'IPv4'
  }
}

resource nic_vm 'Microsoft.Network/networkInterfaces@2020-08-01' = {
  name: vmName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAddress: privateIPAddress
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: subnetId
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
          publicIPAddress: {
            id: pip.id
          }
        }
      }
    ]
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: false
    enableIPForwarding: false
  }
}


output nicId string = nic_vm.id
