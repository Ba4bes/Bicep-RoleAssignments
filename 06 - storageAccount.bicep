param location string = resourceGroup().location

param roleAssignments array = []

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-08-01' = {
  name:  'example'
  location: location
  sku: {
    name:  'Standard_LRS'
  }
  kind:  'StorageV2'
}

resource RoleAssignment 'Microsoft.Authorization/roleAssignments@2020-10-01-preview' = [for assignment in roleAssignments:{
  name: guid(storageAccount.name, assignment.RoleDefinitionId, assignment.principalId)
  scope: storageAccount
  properties: {
    roleDefinitionId: '/providers/Microsoft.Authorization/roleDefinitions/${assignment.roleDefinitionId}'
    principalId: assignment.principalId
    principalType: assignment.principalType
  }
}]
