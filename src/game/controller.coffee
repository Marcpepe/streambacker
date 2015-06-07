angular.module '%module%.game'
  .controller 'GameController', ($scope, $routeParams, $http) ->
    $scope.twitchId = parseInt $routeParams.twitchId
    $http.get 'https://api.parse.com/1/classes/GameStamp'
      ,
        params:
          include: 'game'
          where:
            game:
              $inQuery:
                where:
                  twitchId: $scope.twitchId
                className: 'Game'
        headers:
          'X-Parse-Application-Id': 'FjV0J1GNH4gNUjwPOPREt5vPmxrn3Ht6vyLaaQ1R'
          'X-Parse-REST-API-Key': 'Tr7Sipvulj7XDT2jx5DpvqwV0nLeEC9BnfIGgpvm'
      .success (data) ->
        $scope.gameStamps = data.results
        $scope.game = data.results[0].game
