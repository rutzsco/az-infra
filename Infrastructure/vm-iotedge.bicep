param nameSuffix string = 'VM1'
param location string = resourceGroup().location
param subnetId string
param ubuntuOsVersion string = '18.04-LTS'
param osDiskType string = 'Standard_LRS'
param vmSize string = 'Standard_D2s_v3'
param username string = 'developer'
param customData64 string = 'Y29uY2F0KCcjY2xvdWQtY29uZmlnCgphcHQ6CiAgcHJlc2VydmVfc291cmNlc19saXN0OiB0cnVlCiAgc291cmNlczoKICAgIG1zZnQubGlzdDoKICAgICAgc291cmNlOiAiZGViIGh0dHBzOi8vcGFja2FnZXMubWljcm9zb2Z0LmNvbS91YnVudHUvMjAuMDQvcHJvZCBmb2NhbCBtYWluIgogICAgICBrZXk6IHwKICAgICAgICAtLS0tLUJFR0lOIFBHUCBQVUJMSUMgS0VZIEJMT0NLLS0tLS0KICAgICAgICBWZXJzaW9uOiBHbnVQRyB2MS40LjcgKEdOVS9MaW51eCkKCiAgICAgICAgbVFFTkJGWXhXSXdCQ0FEQUtvWmhabEp4R05HV3pxVisxT0cxeGlRZW9vd0toc3NHQUt2ZCtidVhDR0lTWkp3VAogICAgICAgIExYWnFJY0lpTFA3cHFkY1pXdEU5YlNjN3lCWTJNYWxEcDlMaXUwS2VreXdRNlZWWDFUNzJOUGY1RXY2eDZETFYKICAgICAgICA3YVZXc0N6VUFGK2ViN0RDOWZQdUZMRWR4bU9FWW9QanpyUTdjQ25TVjRKUXhBcWhVNFQ2T2pidlJhekdsM2FnCiAgICAgICAgT2VpelBYbVJsak10VVV0dEhRWm5SaHRsemttd0lyVWl2YmZGUEQrZkVvSEoxK3VJZGZPelpYOC9vS0hLTGUyagogICAgICAgIEg2MzJrdnNOekpGbFJPVnZHTFlBazJXUmNMdStSampnZ2l4aHdpQitNdS9BOFRmNFY2YitZcHBTNDRxOEV2VnIKICAgICAgICBNK1F2WTdMTlNPZmZTTzZTbHN5OW9pc0dUZGZFMzluQzdwVlJBQkVCQUFHME4wMXBZM0p2YzI5bWRDQW9VbVZzCiAgICAgICAgWldGelpTQnphV2R1YVc1bktTQThaM0JuYzJWamRYSnBkSGxBYldsamNtOXpiMlowTG1OdmJUNkpBVFVFRXdFQwogICAgICAgIEFCOEZBbFl4V0l3Q0d3TUdDd2tJQndNQ0JCVUNDQU1ERmdJQkFoNEJBaGVBQUFvSkVPcytsSzIrRWluUEdwc0gKICAgICAgICAvMzJ2S3kyOUhnNTFIOWRmRkpNeDAvYS9GKzV2S2VDZVZxaW12eVRNMDRDK1hFTk51U2JZWjNlUlBIR0hGTHFlCiAgICAgICAgTU5HeHNmYjdDN1p4RWVXN0ovdlN6UmdIeG03WnZFU2lzVVlSRnEyc2drSitIRkVSTnJxZmNpNDViZGhtclVzeQogICAgICAgIDdTV3c5eWJ4ZEZPa3VRb3lLRDN0Qm1pR2ZPTlFNbEJhT01XZEFzaWM5NjVydkpzZDV6WWFaWkZJMVV3VGtGWFYKICAgICAgICBLSnQzYnAzTmduMXZFWVh3aWpHVGErRlh6NkdMSHVlSndGMEk3dWczNERnVWtBRnZBczhIYWNyMkRSWXhMNVJKCiAgICAgICAgWGROZ2o0SmQyL2c2VDlJbm1XVDBoQVNsanVyK2RKbnpOaU5Da2JuOUtiWDdKL3FLMUliUjh5NTYweVJtRnNVKwogICAgICAgIE5kQ0ZUVzd3WTBGYjFmV0orL0tUc0M0PQogICAgICAgID1KNmdzCiAgICAgICAgLS0tLS1FTkQgUEdQIFBVQkxJQyBLRVkgQkxPQ0stLS0tLSAKcGFja2FnZXM6CiAgLSBtb2J5LWNsaQogIC0gbW9ieS1lbmdpbmUKcnVuY21kOgogIC0gZGNzPSInLCB2YXJpYWJsZXMoJ2RjcycpLCciCiAgLSB8CiAgICAgIHNldCAteAogICAgICAoCgogICAgICAgICMgV2FpdCBmb3IgZG9ja2VyIGRhZW1vbiB0byBzdGFydAogICAgICAgIHdoaWxlIFsgJChwcyAtZWYgfCBncmVwIC12IGdyZXAgfCBncmVwIGRvY2tlciB8IHdjIC1sKSAtbGUgMCBdOyBkbyAKICAgICAgICAgIHNsZWVwIDMKICAgICAgICBkb25lCgogICAgICAgIGFwdCBpbnN0YWxsIC15IGF6aW90LWVkZ2UKCiAgICAgICAgaWYgWyAhIC16ICRkY3MgXTsgdGhlbgogICAgICAgICAgbWtkaXIgL2V0Yy9hemlvdAogICAgICAgICAgd2dldCBodHRwczovL3Jhdy5naXRodWJ1c2VyY29udGVudC5jb20vQXp1cmUvaW90ZWRnZS12bS1kZXBsb3kvMS4yL2NvbmZpZy50b21sIC1PIC9ldGMvYXppb3QvY29uZmlnLnRvbWwKICAgICAgICAgIHNlZCAtaSAicyNcKGNvbm5lY3Rpb25fc3RyaW5nID0gXCkuKiNcMVwiJGRjc1wiI2ciIC9ldGMvYXppb3QvY29uZmlnLnRvbWwKICAgICAgICAgIGlvdGVkZ2UgY29uZmlnIGFwcGx5IC1jIC9ldGMvYXppb3QvY29uZmlnLnRvbWwKICAgICAgICBmaQoKICAgICAgKSAmCgonKQ=='

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
      linuxConfiguration: linuxConfiguration,
      customData: customData64
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
