# Description:
#   assigns random reviewer for a pull request
#
# Configuration:
#   N/A
#
# Commands:
#   this script just detects misspellings of "hubot"
#
# Author:
#   sakatam


module.exports = (robot) ->
  NAME = robot.name
  matchers = []
  for c, i in NAME
    matchers.push "#{NAME.substring(0, i)}[^#{c}]#{NAME.substring(i+1)}"
  regex = ///^(#{matchers.join "|"})\b///i

  robot.hear regex, (msg) ->
    msg.reply "you want me, sir? but my name is \"hubot\" not \"#{msg.match[1]}\"."
