# Description:
#   Returns the Leonardi Leitwerk lunch menu for today
#
# Commands:
#   hubot leitwerk - Returns the Leonardi Leitwerk lunch menu for today

cheerio = require('cheerio')

module.exports = (robot) ->

  robot.respond /(leitwerk|wos gibtsn heid).*/i, (msg) ->
    msg.http('http://www.leonardi-kg.de/foodmenu/?password=leitwerk&submit=Senden')
      .get() (err, res, body) ->
        try
          if res.statusCode == 404
            msg.send "Sorry, seems the page has been moved."
          else
            $ = cheerio.load(body)
            uri = $('#post-content > p > img').first().attr('src')

            if uri?.length > 0
              msg.send uri
            else
              msg.send "Sorry, seems the menu hasn't been updated. Try later again."

        catch error
          msg.send "And the error is ... " + error
