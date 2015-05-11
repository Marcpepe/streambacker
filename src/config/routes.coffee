angular.module '%module%'
.config ($routeProvider) ->
    $routeProvider.otherwise
      redirectTo: '/'
