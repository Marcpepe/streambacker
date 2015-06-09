angular.module '%module%.channel'
  .controller 'ChannelController', ($scope, $routeParams, $http) ->
    $scope.twitchId = parseInt $routeParams.twitchId
    $http.get 'https://api.parse.com/1/classes/StreamStamp'
      ,
        params:
          include: 'channel'
          where:
            channel:
              $inQuery:
                where:
                  twitchId: $scope.twitchId
                className: 'Channel'
        headers:
          'X-Parse-Application-Id': 'FjV0J1GNH4gNUjwPOPREt5vPmxrn3Ht6vyLaaQ1R'
          'X-Parse-REST-API-Key': 'Tr7Sipvulj7XDT2jx5DpvqwV0nLeEC9BnfIGgpvm'
      .success (data) ->
        $scope.streamStamps = data.results
        $scope.channel = data.results[0].channel