angular.module 'streambacker'
.config ($routeProvider) ->
    $routeProvider.otherwise
      redirectTo: '/'
