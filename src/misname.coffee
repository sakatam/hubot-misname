# Description:
#   tells people when Hubot's name is misspelled
#
# Configuration:
#   N/A
#
# Author:
#   sakatam


module.exports = (robot) ->
  NAME = robot.name
  matchers = []
  for c, i in NAME
    matchers.push "#{NAME.substring(0, i)}[^#{c}]?#{NAME.substring(i+1)}"
  regex = ///^(#{matchers.join "|"})\b///i

  robot.hear regex, (msg) ->
    msg.reply "You want me, sir? but my name is \"hubot\" not \"#{msg.match[1]}\"."
