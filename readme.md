Tatsu HuBot
===========

Idea: Setup HuBot inside a Docker container and run it on AWS. Automatically build and deploy it with CirclCI.

[![Circle CI](https://circleci.com/gh/pgarbe/tatsu-hubot.svg?style=svg)](https://circleci.com/gh/pgarbe/tatsu-hubot)

### How to build and run it
    docker build -t tatsu .
    docker run -e HUBOT_SLACK_TOKEN=xxx -d tatsu

### Add new scripts
1. Add the following line in the dockerfile to install the NodeJS module:

    RUN npm install [MyHuBotModule] --save && npm install

2. Extend the external-scripts.json file with the name of the NodeJS module:

  [ "...",
    "MyHuBotModule"
    ]


### Next steps
* Build container automatically and deploy to Docker Hub
* Deploy container automatically to AWS (EC2 or Container services?)
* Where to configure passwords (Slack, ...)
* Persistent brain (Redis?)
