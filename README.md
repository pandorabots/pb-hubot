# pb-hubot

This script allows you to integrate a hosted Pandorabot with Hubot, for deployment on Heroku and Slack. The script listens for all inputs directed at Hubot (via `Hubot.respond()`), and forwards them to the Pandorabots API.

### Prerequisites

 * [Heroku](http://heroku.com) account
 * [Slack](http://slack.com) team and personal account
 * [AIaaS](http://chatbots.io) application and bot credentials
 * Git
 * [Heroku Toolbelt](https://toolbelt.heroku.com/)
 * [Node.js](http://nodejs.org) and [npm](http://npmjs.org)

### Installation instructions

1. Install Yeoman globally on your machine, along with the Hubot generator for Yeoman:

        $ npm install -g yo generator-hubot

2. Create a new directory for your Hubot, and run the generator with `yo`:

        $ mkdir myhubot
        $ cd myhubot
        myhubot$ yo hubot

3. Complete the initialization prompts. Make sure to select `slack` as your Bot adapter:

        ? Owner: your-name <your-name@your-domain.com>
        ? Bot name: myhubot
        ? Description: A simple helpful robot for your Company
        ? Bot adapter: (campfire) slack
        ? Bot adapter: slack

4. Install the `pb-hubot` module to your Hubot project:

        myhubot$ npm install pb-hubot --save

5. Add `pb-hubot` to `external-scripts.json`:

        [
          "pb-hubot",
          ...
        ]

   *Note: You may add another Hubot scripts with same manner here.*

6. Create a new git repository in your Hubot directory:

        myhubot$ git init
        myhubot$ git add .
        myhubot$ git commit -m “Initial commit”

7. Create a new Heroku applicaiton:

        myhubot$ heroku create 
        Creating mystic-meadow-229... done, stack is cedar-XX
        ...

8. Configure the `redistogo` add-on. Hubot requires a Redis server for persistent memory. The `nano` plan is free:

        myhubot$ heroku addons:add redistogo:nano

9. Set Heroku environment variables for Pandorabots (`app_id`, `user_key`, `botname`):

        myhubot$ heroku config:set app_id=140XXXXXXXXXX
        myhubot$ heroku config:set user_key=e64XXXXXXXXXXXXXXXXXXXXXXXXXXX
        myhubot$ heroku config:set botname=mypandorabot

10. Set Heroku environment variable for Slack API token. To obtain this, log in to Slack, and go to the Integrations page. Here, you can add the Hubot integration, and retrieve the token:

        myhubot$ heroku config:set HUBOT_SLACK_TOKEN=xoxb-1234567890-XXXXXXXXXXXXXXXXXXX

11. Add Heroku environment variable for Keep-Alive so as to prevent Hubot from sleeping.

        myhubot$ heroku config:set HUBOT_HEROKU_KEEPALIVE_URL=https://your-heroku-app.herokuapp.com/

   *Note: You may add another Heroku environment variables with same manner here.*

1. Deploy Hubot instance to Heroku App

        myhubot$ git push heroku master
        myhubot$ heroku ps:scale web=1

## Additional Instructions: For local testing

*Note: You may need to do following instructions for local testing only.*

1. Install Redis Server into local OS. Hubot requires Redis Server for its persistent memory.

        (e.g. Debian based Linux)
        $ sudo apt-get install redis-server

2. Add environment variables for Pandorabots into local OS. These must be identical to Heroku environment variables.

        myhubot$ export app_id=140XXXXXXXXXX
        myhubot$ export user_key=e64XXXXXXXXXXXXXXXXXXXXXXXXXXXXX
        myhubot$ export botname=mypandorabot

3. Test your bot. You can talk with the Hubot bot locally by using shell adapter. Push enter key to show `Hubot>` prompt, then say `hubot pb`, followed by an input your Pandorabot will provide a response to:

        myhubot$ bin/hubot
        ...
        Hubot>
        Hubot> hubot pb Hello
        Hubot> Hi there!

