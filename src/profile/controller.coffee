angular.module '%module%.profile'
  .controller 'ProfileController', ($scope, $routeParams, TwitchData, $http) ->
    $scope.id = $routeParams.id
    # $scope.data = TwitchData.getLirik()
    $scope.data = $http.post 'https://api.parse.com/1/functions/getTwitchData'
      ,
        name: 'riotgames'
      ,
        method: 'POST'
        headers:
          'X-Parse-Application-Id': 'FjV0J1GNH4gNUjwPOPREt5vPmxrn3Ht6vyLaaQ1R'
          'X-Parse-REST-API-Key': 'Tr7Sipvulj7XDT2jx5DpvqwV0nLeEC9BnfIGgpvm'
        params:
          name: 'lirik'
    
