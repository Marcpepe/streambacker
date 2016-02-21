WebSocket = require('ws')
nick = 'akadot'
auth = 'oauth:kvvmia2l6d2zh5rqw5269lnm6toica'
channel = 'imaqtpie'

module.exports =
  listen: ->
    ws = new WebSocket('ws://192.16.64.205:80')
    # Open connection
    ws.on 'open', ->
      sails.log.info 'SUCCESS! Websocket Opened for Marc :D !'
      ws.send 'CAP REQ :twitch.tv/tags twitch.tv/commands twitch.tv/membership'
      ws.send 'PASS ' + auth
      ws.send 'NICK ' + nick
      ws.send 'JOIN #' + channel
      return
    #show raw data
    ws.on 'message', (data) ->
      sails.log.info data
      return
    # reply to ping
    ws.on 'message', (data) ->
      if data.lastIndexOf('PING', 0) == 0
        ws.send 'PONG :tmi.twitch.tv'
        sails.log 'PONG Sent'
      return
