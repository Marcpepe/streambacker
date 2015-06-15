angular.module '%module%.channel'
.factory 'twitchGame', ($resource) ->
  $resource 'https://api.parse.com/1/', {},
    getGameStamps:
      method: 'GET'
      url: 'https://api.parse.com/1/classes/GameStamp'
      params:
        include: 'game'
        where:
          game:
            $inQuery:
              where:
                # twitchId: $scope.twitchId
                twitchId: 32399
              className: 'Game'
      headers:
        'X-Parse-Application-Id': 'FjV0J1GNH4gNUjwPOPREt5vPmxrn3Ht6vyLaaQ1R'
        'X-Parse-REST-API-Key': 'Tr7Sipvulj7XDT2jx5DpvqwV0nLeEC9BnfIGgpvm'
