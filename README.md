# Docker fluentd

Docker image with:

- [docker-gen](https://github.com/jwilder/docker-gen)
- [fluentd](http://www.fluentd.org/)
- fluent-plugin-cloudwatch-logs

which tails docker containers logs and sends them to cloudwatch logs.

Fluentd config is created using `/app/config/fluentd.tmpl` docker-gen template and could be easily overwritten in custom Dockerfile:

`ADD my-custom-fluentd-template.tmpl /app/config/fluentd.tmpl`


# Simple usage

`docker run -d -v -e AWS_REGION='us-east-1' /var/run/docker.sock:/tmp/docker.sock -v /var/lib/docker:/var/lib/docker knservis/fluentd`

Logs will be sent to a a group called docker-logs and the stream name will be the docker conatiner name.

# AWS Policy (log write only)

    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Action": [
            "logs:*"
          ],
          "Resource": [
            "arn:aws:logs:us-east-1:*:*"
          ]
        }
      ]
    }