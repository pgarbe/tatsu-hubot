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
RUN yo hubot --owner="Philipp Garbe <pgarbe@autoscout24.com>" --name="Tatsu" --description="Roll, roll, rollercoaster" --defaults

# And go
RUN npm install hubot-slack --save && npm install
