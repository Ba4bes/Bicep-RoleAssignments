param location string = resourceGroup().location

param staRoleAssignments array = [
  {
    roleDefinitionId: '00000000-0000-0000-0000-000000000000'
    principalId: '00000000-0000-0000-0000-000000000000'
    principalType: 'User'
  }
]

module storageAccount '06 - storageAccount.bicep' = {
  name: 'storageAccountDeployment'
  params: {
    location: location
    roleAssignments: staRoleAssignments
  }
}
