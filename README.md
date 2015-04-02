# pb-hubot

## Quick Instructions: Pandorabots staying in Slack, powered by Hubot on Heroku.

This is a Pandorabots-with-Slack-specific version of the more general [Getting Started With Hubot](https://hubot.github.com/docs/).

*Note: You will need both a* `user_key` *and* `app_id`*, which you can register for at the [Pandorabots Developer Portal](http://developer.pandorabots.com). In addition you will need your own bot named* `botname` *associated with the account.*

### Prerequisites

 * Heroku account
 * Slack account
 * Pandorabots account and a Pandorabots bot
 * Local OS environment such as Linux, OS X, Windows
 * Git installed on Local OS
 * Heroku Toolbelt installed on Local OS
 * Node.js/npm installed on Local OS

### Installation instructions

1. Install Hubot with Yeoman Generator and Hubot generator into local OS.

        $ npm install -g yo generator-hubot

1. Create Hubot instance on local OS. Create a directory for the instance, then run *Yeoman Generator for Hubot* in the directory. In this case we choose `myhubot` as Hubot name.

        $ mkdir myhubot
        $ cd myhubot
        myhubot$ yo hubot

1. Answer to the generator's questions as below. In this case we choose `slack` as bot adapter.

        ? Owner: your-name <your-name@your-domain.com>
        ? Bot name: myhubot
        ? Description: A simple helpful robot for your Company
        ? Bot adapter: (campfire) slack
        ? Bot adapter: slack

1. Install the `pb-hubot` module with --save option.

        myhubot$ npm install pb-hubot --save

1. Add `pb-hubot` to `external-scripts.json`.

        [
          "pb-hubot",
          ...
        ]

   *Note: You may add another Hubot scripts with same manner here.*

1. Turn the directory into Git working directory.

        myhubot$ git init
        myhubot$ git add .
        myhubot$ git commit -m “Initial commit”

1. Create Heroku App for Hubot instance. You need to choose unique name for Heroku app name here. In this case we choose `myhubotapp999`.

        myhubot$ heroku create myhubotapp999
        Creating myhubotapp999... done, stack is cedar-XX
        ...

1. Add Heroku add-ons for Hubot. At least you need to add add-ons `redistogo` as `nano` plan for free. Hubot requires Redis Server for its persistent memory.

        myhubot$ heroku addons:add redistogo:nano

1. Add Heroku environment variables for Pandorabots

        myhubot$ heroku config:set app_id=140XXXXXXXXXX
        myhubot$ heroku config:set user_key=e64XXXXXXXXXXXXXXXXXXXXXXXXXXX
        myhubot$ heroku config:set botname=mypandorabot

1. Add Heroku environment variable for Slack API token. Login to Slack then move to Integrations page, where you can add Hubot Integration. At this point you also get `HUBOT_SLACK_TOKEN` value.

        myhubot$ heroku config:set HUBOT_SLACK_TOKEN=xoxb-1234567890-XXXXXXXXXXXXXXXXXXX

1. Add Heroku environment variable for Keep-Alive so as to prevent Hubot from sleeping.

        myhubot$ heroku config:set HUBOT_HEROKU_KEEPALIVE_URL=https://myhubotapp999.herokuapp.com/

   *Note: You may add another Heroku environment variables with same manner here.*

1. Deploy Hubot instance to Heroku App

        myhubot$ git push heroku master
        myhubot$ heroku ps:scale web=1

## Additional Instructions: For local testing

*Note: You may need to do following instructions for local testing only.*

1. Install Redis Server into local OS. Hubot requires Redis Server for its persistent memory.

        (e.g. Debian based Linux)
        $ sudo apt-get install redis-server

1. Add environment variables for Pandorabots into local OS. These must be identical to Heroku environment variables.

        myhubot$ export app_id=140XXXXXXXXXX
        myhubot$ export user_key=e64XXXXXXXXXXXXXXXXXXXXXXXXXXXXX
        myhubot$ export botname=mypandorabot

1. Test to talk with Hubot bot. You can talk with the Hubot bot locally by using shell adapter. Push enter key to show `Hubot>` prompt, then say `hubot ping` so the bot responses `PONG`. Errors are mostly ignorable here.

        myhubot$ bin/hubot
        ...
        Hubot>
        Hubot> hubot ping
        PONG
        Hubot> ^D

1. Test to talk with Pandorabots bot. You can talk with Pandorabts bot through Hubot bot. By default, you need to say `pb` after Hubot name `hubot` so as to redirect an inquiry to Pandorabots bot.

        myhubot$ bin/hubot
        ...
        Hubot>
        Hubot> hubot pb gender?
        Hubot> I am female.
        Hubot> ^D

