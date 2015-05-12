FROM ubuntu

RUN apt-get update
RUN apt-get -y install expect redis-server nodejs npm
RUN ln -s /usr/bin/nodejs /usr/bin/node

RUN npm install -g coffee-script
RUN npm install -g yo generator-hubot

# Create hubot user
RUN	useradd -d /hubot -m -s /bin/bash -U hubot

# Log in as hubot user and change directory
USER	hubot
WORKDIR /hubot

# Install hubot
RUN yo hubot --owner="Tatsu <inside@autoscout24.com>" --name="Tatsu" --description="Roll, roll, rollercoaster" --defaults

# Some adapters / scripts
RUN npm install hubot-slack --save && npm install
RUN npm install hubot-standup-alarm --save && npm install
RUN npm install hubot-auth --save && npm install
RUN npm install hubot-google-translate --save && npm install
RUN npm install hubot-auth --save && npm install
RUN npm install hubot-github --save && npm install
RUN npm install hubot-alias --save && npm install
RUN npm install hubot-gocd --save && npm install


# Activate some built-in scripts
ADD hubot/hubot-scripts.json /hubot/
ADD hubot/external-scripts.json /hubot/

RUN npm install cheerio --save && npm install
ADD hubot/scripts/hubot-leitwerk.coffee /hubot/scripts/
ADD hubot/scripts/hubot-lunch.coffee /hubot/scripts/

# And go
CMD ["bin/hubot", "--adapter", "slack"]
# CMD source env.sh && ./bin/hubot --adapter slack
# CMD [ "sh", "-c", "source /usr/share/tatsu-hubot/env.sh", "./bin/hubot --adapter slack" ]
# https://forums.aws.amazon.com/thread.jspa?messageID=616512&#616512
