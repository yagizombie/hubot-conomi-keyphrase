# Description
#   特徴語抽出をする
#   http://developer.yahoo.co.jp/webapi/jlp/keyphrase/v1/extract.html
#
# Configuration:
#   CONOMI_YD_APP_ID Yahoo! JAPANのWebサービスを利用するためのアプリケーションID
#
# Commands:
#   hubot 特徴語抽出 <text> - <text>の特徴語を抽出する
#
# Author:
#   yagizombie <yanagihara+zombie@brainpad.co.jp>

http = require 'http'

APP_ID = process.env.CONOMI_YD_APP_ID

module.exports = (robot) ->
    robot.respond /(特徴語抽出|keyphrase)\s(.*)$/i, (msg) ->
        h = "jlp.yahooapis.jp"
        p = "/KeyphraseService/V1/extract?appid=" + APP_ID
        p += "&output=json&sentence=" + encodeURIComponent(msg.match[2])

        msg.send "むむっ (grumpycat)"

        req = http.get { host:h, path:p }, (res) ->
            contents = ""
            res.on 'data', (chunk) ->
                contents += "#{chunk}"

            res.on 'end', () ->
                rep = "/quote  ∴‥∵‥∴‥∵‥∴‥∴‥∵‥∴‥∵‥∴‥∴‥∵‥∴‥∵‥∴‥∴‥∵‥∴\n"
                j = JSON.parse contents
                for key,value of j
                    rep += key + ": " + value + "\n"
                msg.send rep
                msg.send "こんな感じ♪ @#{msg.message.user.mention_name}"

        req.on "error", (e) ->
            msg.send "(fu) ひでぶっ!!  ... {e.message}"

