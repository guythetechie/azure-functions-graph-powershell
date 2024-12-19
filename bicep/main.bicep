targetScope = 'subscription'

var prefix = 'func-graph'
var resourceGroupName = 'func-graph-${take(uniqueString(subscription().id), 4)}-rg'
var location = 'eastus2'
var tags = {}

resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
  tags: tags
}

module resourceDeployment 'resources.bicep' = {
  name: 'resource-deployment'
  scope: resourceGroup
  params: {
    location: location
    tags: tags
    prefix: '${prefix}-${take(uniqueString(resourceGroup.id), 4)}'
  }
}

output resourceGroupName string = resourceGroup.name
output functionAppName string = resourceDeployment.outputs.functionAppName
