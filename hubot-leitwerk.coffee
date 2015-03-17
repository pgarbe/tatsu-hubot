# Description:
#   Returns the Leonardi Leitwerk lunch menu for today
#
# Commands:
#   hubot leitwerk me - Returns the Leonardi Leitwerk lunch menu for today
module.exports = (robot) ->
  robot.respond /(leitwerk).*/i, (msg) ->

    now = new Date()
    day = zero_pad(now.getDate())
    month = zero_pad(now.getMonth() + 1)
    year = now.getFullYear()
    shortyear = year - 2000

    leitwerkUrl = "http://leonardi-kg.de/wp-content/uploads/#{year}/#{month}/#{shortyear}#{month}#{day}_Speiseplan_HPM_extern.jpg"
    msg.send leitwerkUrl


  zero_pad = (x) ->
    if x < 10 then '0'+x else ''+x
