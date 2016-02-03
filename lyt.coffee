# Description:
#   Example scripts for you to examine and try out.
# 
# Commands:
#   hubot upgrade                - Oppdater webspiller-bot'en til nyeste versjon fra git
#   hubot webspiller test        - Installer nyeste versjon for testing
#   hubot webspiller test COMMIT - Installer gitt git commit, git branch eller git tag for testing
# 

child_process = require 'child_process'

module.exports = (robot) ->
  
#  script_dir = process.env.BASH_SCRIPTS_DIR
#  
#  child_process.exec script_dir+"/slack \"bot er våken!\"", (error, stdout, stderr) ->
#    "foo"
#
#  robot.respond /webspiller upgrade/i, (res) ->
#    child_process.exec script_dir+"/upgrade", (error, stdout, stderr) ->
#      "foo"
#        
#  
#  robot.respond /webspiller test/i, (res) ->
#    child_process.exec script_dir+"/test", (error, stdout, stderr) ->
#      "foo"
#  
#  robot.respond /webspiller test (.*)/i, (res) ->
#    child_process.exec script_dir+"/test "+res.match[1], (error, stdout, stderr) ->
#      "foo"
