# Hubot script for Pandrabots API.

nconf   = require 'nconf'
request = require 'request'
url     = require 'url'

sep = (str) ->
  if str then '/' + str else ''

conf_app_id = () ->
  app_id = nconf.get 'app_id'
  if app_id == undefined
    console.log 'please set app_id'
    process.exit 1
  app_id

conf_user_key = () ->
  user_key = nconf.get 'user_key'
  if user_key == undefined
    console.log 'please set user_key'
    process.exit 1
  user_key

conf_botname = () ->
  botname = nconf.get 'botname'
  if botname == undefined
    console.log 'please set botname'
    process.exit 1
  botname

composeParams = (params) ->
  params.user_key = conf_user_key()
  params

composeUri = (mode, botname, kind, filename) ->
  uri =
    protocol: nconf.get 'protocol'
    hostname: nconf.get 'hostname'
    port: nconf.get 'port'
  path = mode
  path += sep conf_app_id()
  path += sep botname
  path += sep kind
  path += sep filename
  uri.pathname = path
  uri

talkUri = () ->
  url.format composeUri('talk', conf_botname(), '', '')

talkResp = (error, response, body) ->
  jObj = JSON.parse body
  if jObj.status == 'ok'
    nconf.set('sessionid', jObj.sessionid)
    if (nconf.get('extra') || nconf.get('trace'))
      JSON.stringify jObj
    else
      jObj.responses.join(' ')
  else
    jObj.message

options =
  protocol: 'https'
  hostname: 'aiaas.pandorabots.com'
  port: undefined
  app_id: undefined
  user_key: undefined
  botname: undefined
  client_name: undefined
  sessionid: undefined
  extra: undefined
  reset: undefined
  trace: undefined
  reload: undefined
  recent: undefined
  all: undefined

nconf.env()
nconf.defaults options

module.exports = (robot) ->

  robot.respond /(.*)/, (msg) ->
    user = msg.message.user.name
    query = msg.match[1]

    if query
      param = input: query
      param.client_name = nconf.get 'client_name' if nconf.get 'client_name'
      param.sessionid = nconf.get 'sessionid'     if nconf.get 'sessionid'
      param.extra = true                          if nconf.get 'extra'
      param.reset = true                          if nconf.get 'reset'
      param.trace = true                          if nconf.get 'trace'
      param.reload = true                         if nconf.get 'reload'
      param.recent = true                         if nconf.get 'recent'
      a = request.post {url: talkUri(), form: composeParams param},
        (error, response, body) ->
          msg.send talkResp(error, response, body)

