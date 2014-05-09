# Webhook -> SQS

[![Build Status](https://travis-ci.org/ukd1/webhook-sqs-router.png)](https://travis-ci.org/ukd1/webhook-sqs-router)

This project takes HTTP GET or POST requests and pushes them in to SQS for you to process later.

## Setup

### Prerequisites

1. Setup an SQS queue
2. Setup an IAM user, note down the public and secret keys
3. Apply the following IAM policy (customise for your arn)

```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1399607812000",
      "Effect": "Allow",
      "Action": [
        "sqs:SendMessage"
      ],
      "Resource": [
        "<your arn>"
      ]
    }
  ]
}
```

### Install the app

```
git clone https://github.com/ukd1/webhook-sqs-router.git
cd webhook-sqs-router
heroku create
git push heroku -u master
heroku config:set SQS_QUEUE=xxxx SQS_PUBLIC_KEY=xxxx SQS_SECRET_KEY=xxxx
```

## Use
Non root (i.e. /) GET or POST request are pushed to SQS in the following format;

```json
{'request': {'host': 'your-heroku-app.herokuapp.com', 'method': 'GET', 'path': '/path_to_request', 'ts': '2014-05-08 ....'}, 'params': {'your': 'params'}}
```