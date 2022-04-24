# Deploy to a Management group
$Parameters = @{
    TemplateFile      = '.\rbac-mg.bicep'
    ManagementGroupId = 'ExampleGroup'
    Location          = 'WestEurope'
    PrincipalType     = 'User'
    PrincipalId       = (Get-AzADUser -UserPrincipalName example@domain.com).id
    RoleDefinitionId  = (Get-AzRoleDefinition -Name 'Reader').id
}

New-AzManagementGroupDeployment @parameters -Verbose


#Deploy to a subscription
$Parameters = @{
    TemplateFile     = 'rbac-sub.bicep'
    Location         = 'WestEurope'
    PrincipalType    = 'User'
    PrincipalId      = (Get-AzADUser -UserPrincipalName example@domain.com).id
    RoleDefinitionId = (Get-AzRoleDefinition -Name 'Reader').id
}

New-AzDeployment @parameters -Verbose


#Deploy to a resource group
$Parameters = @{
    TemplateFile      = 'rbac-rg.bicep'
    ResourceGroupName = 'example'
    PrincipalType     = 'User'
    PrincipalId       = (Get-AzADUser -UserPrincipalName example@domain.com).id
    RoleDefinitionId  = (Get-AzRoleDefinition -Name 'Reader').id
}

New-AzResourceGroupDeployment @parameters -Verbose


#Deploy to a resource
$Parameters = @{
    TemplateFile      = 'rbac-res.bicep'
    ResourceGroupName = 'example'
    PrincipalType     = 'User'
    PrincipalId       = (Get-AzADUser -UserPrincipalName example@domain.com).id
    RoleDefinitionId  = (Get-AzRoleDefinition -Name 'Reader').id
}

New-AzResourceGroupDeployment @parameters -Verbose

# Deploy a module
$Parameters = @{
    TemplateFile         = '.\07 - RBACModule.bicep'
    ResourceGroupName    = 'example'
    rbacprincipalId      = (Get-AzADUser -UserPrincipalName example@domain.com).id
    rbacRoleDefinitionId = (Get-AzRoleDefinition -Name 'Contributor').id
}

New-AzResourceGroupDeployment @parameters -Verbose


# Deploy with the role assignment in an array
$RoleAssignments = @(
    @{
        roleDefinitionId = '00000000-0000-0000-0000-000000000000'
        principalId      = '00000000-0000-0000-0000-000000000000'
        principalType    = 'User'
    }
)


$Parameters = @{
    TemplateFile      = '.\06 - storageAccount.bicep'
    ResourceGroupName = 'example'
    RoleAssignments   = $RoleAssignments
}

New-AzResourceGroupDeployment @parameters -Verbose