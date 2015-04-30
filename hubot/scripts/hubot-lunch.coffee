# Description:
#   Returns the local lunch menues for today
#
# Commands:
#   hubot lunch - Returns all lunch menues for today
#   hubot lunch leitwerk - Returns the Leonardi Leitwerk lunch menu for today
#   hubot lunch snackattack - Returns the SnackAttack lunch menu for today

cheerio = require('cheerio')

module.exports = (robot) ->

  robot.respond /lunch ?(.*)?/i, (msg) ->
    canteen = msg.match[1]

    if canteen?
      switch canteen
        when "leitwerk"
          checkLeitwerk msg
        when "snackattack"
          checkSnackAttack msg
        else
          msg.send "Send a PR to support this canteen!"
          msg.send "https://github.com/pgarbe/tatsu-hubot"
    else
      checkSnackAttack msg
      checkLeitwerk msg

  checkSnackAttack = (msg) ->
    msg.http('http://wohin-mittags.de/restaurantliste/restaurant/snack-attack.html')
      .get() (err, res, body) ->
        try
          if res.statusCode == 404
            msg.send "Sorry, seems the page has been moved."
          else
            $ = cheerio.load(body)
            menu = $('.tx_in2wm_show_all_menu_day.today').text()
            menu = menu.replace(/\s{3,}/g, '\n')

            if menu?.length > 0
              msg.send "SnackAttack"
              msg.send menu
            else
              msg.send "Sorry, seems the menu can't be found. Try later again."

        catch error
          msg.send "And the error is ... " + error

  checkLeitwerk = (msg) ->
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
