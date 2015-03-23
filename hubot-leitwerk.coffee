# Description:
#   Returns the Leonardi Leitwerk lunch menu for today
#
# Commands:
#   hubot leitwerk me - Returns the Leonardi Leitwerk lunch menu for today
module.exports = (robot) ->

  robot.respond /(leitwerk).*/i, (msg) ->
    imageMe msg, (url) ->
      msg.send url

imageMe = (msg, cb) ->
  msg.http('http://www.leonardi-kg.de/foodmenu/?password=leitwerk&submit=Senden')
    .get() (err, res, body) ->
      if response.statusCode == 404
        cb "Sorry, seems the page has been moved."
      else
        images = JSON.parse(body)
        images = images.responseData?.results
        if images?.length > 0
          image = msg.random images
          cb ensureImageExtension image.unescapedUrl
        else
          cb "Sorry, seems the menu hasn't been updated. Try later again."


ensureImageExtension = (url) ->
  ext = url.split('.').pop()
  if /(png|jpe?g|gif)/i.test(ext)
    url
  else
    "#{url}#.png"



  zero_pad = (x) ->
    if x < 10 then '0'+x else ''+x
