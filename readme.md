Tatsu HuBot

Idea: Setup HuBot inside a Docker container and run it on AWS. Automatically build and deploy it with Travis-CI.

#Run it
  docker build -t tatsu .
  docker run -e HUBOT_SLACK_TOKEN=xxx -d tatsu

#Next steps
* Build container automatically with Travis-CI
* Deploy container automatically to AWS (EC2 or Container services?)
* Where to configure passwords (Slack, ...)
* Persistent brain (Redis?)
