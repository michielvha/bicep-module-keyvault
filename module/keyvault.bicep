@allowed([
  'westeurope'
  'northeurope'
])
param location string
@allowed([
  'acceptance'
  'production'
  'integration'
])
param environment string
param kvSkuName string
param purpose string

var envShort = {
  production: 'prd'
  acceptance: 'acc'
  integration: 'int'
}
var locShort = {
  westeurope: 'we'
  northeurope: 'ne'
}
var kvName = 'kvault-${locShort[location]}-${envShort[environment]}-${purpose}'

resource myKeyVault 'Microsoft.KeyVault/vaults@2025-05-01' = {
  name: kvName
  location: location
  properties: {
    sku: {
      family: 'A'
      name: kvSkuName
    }
    tenantId: tenant().tenantId
    enableRbacAuthorization: true
    createMode: 'default'
  }

}
