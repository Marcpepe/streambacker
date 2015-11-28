###
# EnvController
#
# @description :: Allows fetching of environment variables
#
###

module.exports = hostname: (req, res) ->
  sails.log 'Fetching hostname.. ', process.env.HOSTNAME
  envVar =
    'name': process.env.HOSTNAME
  res.send envVar

