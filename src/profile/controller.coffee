angular.module '%module%.profile'
  .controller 'ProfileController', ($scope, $routeParams, $http) ->
    console.log "my twitch id is : ", $routeParams.twitchId
    $scope.twitchId = $routeParams.twitchId
    # $scope.data = TwitchData.getLirik()
    $http.get 'https://api.parse.com/1/classes/Channel'
      ,
        # where: '{twitchId:'+$routeParams.twitchId+'}'
        # data: 'where={"twitchId":'+$routeParams.twitchId+'}'
        # data: 'where={twitchId:'+$routeParams.twitchId+'}'
        data: 'where={"twitchId":23161357}'
        # 'where={"twitchId":23161357}'
        # data: encodeURIComponent 'where={"twitchId":'+$routeParams.twitchId+'}'
      # ,
        # method: 'GET'
        headers:
          'X-Parse-Application-Id': 'FjV0J1GNH4gNUjwPOPREt5vPmxrn3Ht6vyLaaQ1R'
          'X-Parse-REST-API-Key': 'Tr7Sipvulj7XDT2jx5DpvqwV0nLeEC9BnfIGgpvm'
      .success (data) ->
        console.log "yellow", JSON.stringify(data)
        $scope.channel = data.result
