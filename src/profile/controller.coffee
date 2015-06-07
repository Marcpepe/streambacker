angular.module '%module%.profile'
  .controller 'ProfileController', ($scope, $routeParams, $http) ->
    console.log "my twitch id is : ", $routeParams.twitchId
    $scope.twitchId = $routeParams.twitchId
    # $scope.data = TwitchData.getLirik()
    $http.get 'https://api.parse.com/1/classes/Channel'
      ,
        params:
          where:
            twitchId: 23161357
        headers:
          'X-Parse-Application-Id': 'FjV0J1GNH4gNUjwPOPREt5vPmxrn3Ht6vyLaaQ1R'
          'X-Parse-REST-API-Key': 'Tr7Sipvulj7XDT2jx5DpvqwV0nLeEC9BnfIGgpvm'
      .success (data) ->
        console.log "yellow", JSON.stringify(data)
        $scope.channel = data.results[0]
