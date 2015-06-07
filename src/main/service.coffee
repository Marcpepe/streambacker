angular.module '%module%.channel'
.factory 'Twitch', ($resource) ->
  $resource 'https://api.parse.com/1/classes/Channel', {},
    getChannels:
      method: 'GET'
      headers:
        'X-Parse-Application-Id': 'FjV0J1GNH4gNUjwPOPREt5vPmxrn3Ht6vyLaaQ1R'
        'X-Parse-REST-API-Key': 'Tr7Sipvulj7XDT2jx5DpvqwV0nLeEC9BnfIGgpvm'
      # data:
        # 'where={"name":"lirik"}'
      # # isArray: true
      # # withCredentials: true
