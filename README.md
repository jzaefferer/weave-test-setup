# weave-test-setup

needs vagrant
```
$ vagrant up
$ vagrant ssh node1
# now inside the box
$ sudo su
# now as root
$ /vagrant/start.sh
# repeat 3 times
$ docker ps
$ docker stop x y
$ weave status dns
# repeat until `weave status dns` shows more addresses than it should
