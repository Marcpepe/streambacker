angular.module '%module%.channel'
.config ($routeProvider) ->
  $routeProvider.when '/channel/:twitchId',
    templateUrl: 'channel/view.html'
    controller: 'ChannelController'
    resolve:
      streamStamps: (twitchChannel) ->
        return twitchChannel.getStreamStamps().$promise
