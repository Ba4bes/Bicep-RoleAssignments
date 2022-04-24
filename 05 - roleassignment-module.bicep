param rbacprincipalId string
param rbacRoleDefinitionId string

module rbac '03 - rollassignment-ResourceGroup.bicep' = {
  name: 'rbac-Deployment'
  params: {
    principalId: rbacprincipalId
    principalType: 'User'
    RoleDefinitionId: rbacRoleDefinitionId
  }
}
