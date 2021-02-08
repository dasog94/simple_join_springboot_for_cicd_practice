#!/bin/bash
find /opt/codedeploy-agent/deployment-root/4ca5303f-14ae-419a-b8f9-fe8a2b1a045f/* -maxdepth 0 -type 'd' | grep -v $(stat -c '%Y:%n' /opt/codedeploy-agent/deployment-root/4ca5303f-14ae-419a-b8f9-fe8a2b1a045f/* | sort -t: -n | tail -1 | cut -d: -f2- | cut -c 3-) | xargs rm -rf
sudo rm -rf /home/ec2-user/*
