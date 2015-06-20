angular.module '%module%.channel'
.factory 'twitchChannel', ($resource, $route) ->
  $resource 'https://api.parse.com/1/', {},
    getStreamStamps:
      method: 'GET'
      url: 'https://api.parse.com/1/classes/StreamStamp'
      params:
        order: '-createdAt'
        skip: 100
        limit: 400
        include: 'channel'
        where:
          channel:
            $inQuery:
              where:
                twitchId: parseInt $route.current.params.twitchId
              className: 'Channel'
      headers:
        'X-Parse-Application-Id': 'FjV0J1GNH4gNUjwPOPREt5vPmxrn3Ht6vyLaaQ1R'
        'X-Parse-REST-API-Key': 'Tr7Sipvulj7XDT2jx5DpvqwV0nLeEC9BnfIGgpvm'
