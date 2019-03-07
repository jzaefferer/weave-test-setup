#!/bin/bash
set -e
docker -H unix:///var/run/weave/weave.sock run -d -e WEAVE_CIDR=net:10.1.0.0/24 -h web1.node.intern nginx:alpine
