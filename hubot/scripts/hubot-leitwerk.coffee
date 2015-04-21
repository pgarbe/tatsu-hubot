# Description:
#   Returns the Leonardi Leitwerk lunch menu for today
#
# Commands:
#   hubot leitwerk - DEPRECATED. Use hubot lunch.

module.exports = (robot) ->

  robot.respond /(leitwerk|wos gibtsn heid).*/i, (msg) ->
    msg.send "DEPRECATED. Please use 'tatsu lunch' or 'tatsu lunch leitwerk' instead"
