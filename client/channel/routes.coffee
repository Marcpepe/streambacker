angular.module 'streambacker.channel'
.config ($stateProvider) ->
  $stateProvider
    .state 'channel',
      url: '/channel/:twitchId',
      templateUrl: 'channel/view.html'
      controller: 'ChannelController'
      resolve:
        streamStamps: (twitchChannel) ->
          return twitchChannel.getStreamStamps().$promise
