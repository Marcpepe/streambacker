angular.module 'streambacker.main'
.factory 'twitchMain', ($resource) ->
  $resource 'https://api.parse.com/1/', {},
    getChannels:
      method: 'GET'
      url: 'https://api.parse.com/1/classes/Channel'
      headers:
        'X-Parse-Application-Id': 'FjV0J1GNH4gNUjwPOPREt5vPmxrn3Ht6vyLaaQ1R'
        'X-Parse-REST-API-Key': 'Tr7Sipvulj7XDT2jx5DpvqwV0nLeEC9BnfIGgpvm'
    getGames:
      method: 'GET'
      url: 'https://api.parse.com/1/classes/Game'
      headers:
        'X-Parse-Application-Id': 'FjV0J1GNH4gNUjwPOPREt5vPmxrn3Ht6vyLaaQ1R'
        'X-Parse-REST-API-Key': 'Tr7Sipvulj7XDT2jx5DpvqwV0nLeEC9BnfIGgpvm'
      params:
        order: '-maxViewers'
