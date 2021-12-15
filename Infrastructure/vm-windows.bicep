param nameSuffix string = 'VM1'
param location string = resourceGroup().location
param subnetId string
param osDiskType string = 'Standard_LRS'
param vmSize string = 'Standard_B1s'
param username string = 'developer'
param password string

param frontendRG string
param frontendRG string

var vmName = 'WIN11${location}${nameSuffix}'

// Bring in the nic
module nic 'vm-small-nic.bicep' = {
  name: '${vmName}-nic'
  params: {
    namePrefix: '${vmName}-hdd'
    subnetId: subnetId
  }
}

resource vm_windows 'Microsoft.Compute/virtualMachines@2020-12-01' = {
  name: vmName
  location: resourceGroup().location
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
      computerName: vmName
      adminUsername: username
      adminPassword: password
    }
    storageProfile: {
      imageReference: {
        publisher: 'microsoftwindowsdesktop'
        offer: 'windows-11'
        sku: 'win11-21h2-pro'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: osDiskType
        }
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic.outputs.nicId
        }
      ]
    }
  }
}

output vm_id string = vm_windows.id
