FROM ubuntu

RUN apt-get update
RUN apt-get -y install expect redis-server nodejs npm

RUN apt-get update && \
    apt-get install -y python-pip && \
    pip install awscli

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

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
RUN npm install hubot-youtube --save && npm install
RUN npm install hubot-s3-brain --save && npm install

# Activate some built-in scripts
ADD hubot/hubot-scripts.json /hubot/
ADD hubot/external-scripts.json /hubot/

RUN npm install cheerio --save && npm install
ADD hubot/scripts/hubot-lunch.coffee /hubot/scripts/

# And go
CMD ["/bin/sh", "-c", "aws s3 cp --region eu-west-1 s3://pgarbe-secrets/env.sh .; . ./env.sh; bin/hubot --adapter slack"]
