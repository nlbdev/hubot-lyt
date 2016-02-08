# Description:
#   Example scripts for you to examine and try out.
# 
# Commands:
#   hubot upgrade                 - Oppdater webspiller-bot'en til nyeste versjon fra git
#   hubot webspiller status       - Vis informasjon om test-server og drift-server
#   hubot webspiller test         - Installer nyeste versjon for testing
#   hubot webspiller test COMMIT  - Installer gitt git commit, git branch eller git tag for testing
#   hubot webspiller sett i drift - Kopier versjonen som er installert på test-serveren over på drift-serveren
# 

child_process = require 'child_process'

module.exports = (robot) ->
  
  script_dir = process.env.BASH_SCRIPTS_DIR
  
  # send message on startup
  child_process.exec "echo \"Jeg er våken!\" | \""+script_dir+"/slack\" info", (error, stdout, stderr) ->
  
  robot.respond /upgrade *$/i, (res) ->
    child_process.exec "\""+script_dir+"/upgrade\"", (error, stdout, stderr) ->
  
  robot.respond /webspiller test *$/i, (res) ->
    child_process.exec "\""+script_dir+"/test\"", (error, stdout, stderr) ->
  
  robot.respond /webspiller test (.*)/i, (res) ->
    child_process.exec "\""+script_dir+"/test\" "+res.match[1], (error, stdout, stderr) ->
  
  robot.respond /webspiller status *$/i, (res) ->
    child_process.exec "\""+script_dir+"/status\" "+res.match[1], (error, stdout, stderr) ->
  
  robot.respond /webspiller( sett i)? drift *$/i, (res) ->
    child_process.exec "\""+script_dir+"/drift\" "+res.match[1], (error, stdout, stderr) ->
