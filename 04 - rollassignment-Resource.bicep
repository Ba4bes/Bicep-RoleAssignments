@description('Principal type of the assignee.')
@allowed([
  'Device'
  'ForeignGroup'
  'Group'
  'ServicePrincipal'
  'User'
])
param principalType string

@description('the id for the role defintion, to define what permission should be assigned')
param RoleDefinitionId string

@description('the id of the principal that would get the permission')
param principalId string

param location string = resourceGroup().location

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-08-01' = {
  name:  'example'
  location: location
  sku: {
    name:  'Standard_LRS'
  }
  kind:  'StorageV2'
}


resource roleDefinition 'Microsoft.Authorization/roleDefinitions@2018-01-01-preview' existing = {
  scope: resourceGroup()
  name: RoleDefinitionId
}

resource RoleAssignment 'Microsoft.Authorization/roleAssignments@2020-10-01-preview' = {
  name: guid(storageAccount.id, RoleDefinitionId, principalId)
  scope: storageAccount
  properties: {
    roleDefinitionId: roleDefinition.id
    principalId: principalId
    principalType: principalType
  }
}
