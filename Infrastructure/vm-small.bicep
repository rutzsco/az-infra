param nameSuffix string = 'VM1'
param location string = resourceGroup().location
param subnetId string
param ubuntuOsVersion string = '18.04-LTS'
param osDiskType string = 'Standard_LRS'
param vmSize string = 'Standard_B1s'
param username string = 'developer'

@description('SSH Key or password for the Virtual Machine. SSH key is recommended.')
param password string

var vmName = 'Ubuntu${location}${nameSuffix}'
var pipName = '${vmName}-pip'
var linuxConfiguration = {
  disablePasswordAuthentication: true
  ssh: {
    publicKeys: [
      {
        path: '/home/${username}/.ssh/authorized_keys'
        keyData: password
      }
    ]
  }
}
resource pip 'Microsoft.Network/publicIPAddresses@2020-08-01' = {
  name: pipName
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    publicIPAllocationMethod: 'Dynamic'
    publicIPAddressVersion: 'IPv4'
    idleTimeoutInMinutes: 4
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

// Create the vm
resource vm_small 'Microsoft.Compute/virtualMachines@2019-07-01' = {
  name: vmName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    storageProfile: {
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: osDiskType
        }
      }
      imageReference: {
        publisher: 'Canonical'
        offer: 'UbuntuServer'
        sku: ubuntuOsVersion
        version: 'latest'
      }
    }
    osProfile: {
      computerName: vmName
      adminUsername: username
      adminPassword: password
      linuxConfiguration: linuxConfiguration
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic_vm.id
        }
      ]
    }
  }
}

output vm_id string = vm_small.id
