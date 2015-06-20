angular.module '%module%.channel'
.factory 'twitchGame', ($resource, $route) ->
  $resource 'https://api.parse.com/1/', {},
    getGameStamps:
      method: 'GET'
      url: 'https://api.parse.com/1/classes/GameStamp'
      params:
        order: '-createdAt'
        skip: 100
        limit: 500
        include: 'game'
        where:
          game:
            $inQuery:
              where:
                twitchId: parseInt $route.current.params.twitchId
              className: 'Game'
      headers:
        'X-Parse-Application-Id': 'FjV0J1GNH4gNUjwPOPREt5vPmxrn3Ht6vyLaaQ1R'
        'X-Parse-REST-API-Key': 'Tr7Sipvulj7XDT2jx5DpvqwV0nLeEC9BnfIGgpvm'
