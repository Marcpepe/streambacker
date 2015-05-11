angular.module '%module%.profile'
.factory 'TwitchData', ($resource) ->
  $resource 'https://api.parse.com/1/functions/getTwitchData', {},
    getLirik:
      method: 'POST'
      headers:
        'X-Parse-Application-Id': 'FjV0J1GNH4gNUjwPOPREt5vPmxrn3Ht6vyLaaQ1R'
        'X-Parse-REST-API-Key': 'Tr7Sipvulj7XDT2jx5DpvqwV0nLeEC9BnfIGgpvm'
      params:
        name: 'lirik' 
      # isArray: true
      # withCredentials: true
