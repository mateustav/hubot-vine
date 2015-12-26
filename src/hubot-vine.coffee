# Description
#   A hubot that gets a random Vine based on tag
#
# Configuration:
#   None, just make sure hubot-vine has been added to your external-scripts.json
#
# Commands:
#   hubot vine <tag> - What triggers your bot to get a random Vine based on given tag
#   <tag> - Any keyword you want to search on Vine
#
# Notes:
#   If you want to look for more than one word, you should combine them together, since these tags are Vine hashtags.
#
# Author:
#   Mateus <mateustavares_@hotmail.com>

module.exports = (robot) ->
  robot.respond /vine (.*)/i, (msg) ->
    query = msg.match[1]
    encoded_query = encodeURIComponent(query)
    param = "?page-id="
    page_id = Math.floor(Math.random() * 450)
    request_url = "https://api.vineapp.com/timelines/tags/"
    robot.http(request_url + encoded_query + param + page_id)
      .get() (err, res, body) ->
        vine_json = JSON.parse(body)
        vines = vine_json.data.records
        random_vine = vines[Math.floor(1 + Math.random() * vines.length)].permalinkUrl
        unless vines?
          msg.send "No Vine results for \"#{query}\". Please try again."
          return
        msg.send random_vine
