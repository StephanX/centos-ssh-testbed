########################

# centos-ssh-testbed: centos 7 + openssh-server
Config: Update root.ssh/authorized_keys with your public key
Build: `docker build --rm -t cst .`

each container will need it's own unique front-door port (i.e. 2222)
`docker run -P --rm -d --name box1 cst`

This will take care of dns addresses for our containers: [https://github.com/jderusse/docker-dns-gen]  This only needs to happen once per session
`export DOCKER0IP=$(ifconfig docker0 | grep "inet" | head -n1 | awk '{ print $2}' | cut -d: -f2)`
`docker run --detach --name dns-gen --publish ${DOCKER0IP}:53:53/udp --volume /var/run/docker.sock:/var/run/docker.sock jderusse/dns-gen`
`echo "nameserver $(echo $DOCKER0IP)" | sudo tee --append /etc/resolvconf/resolv.conf.d/head`
`sudo resolvconf -u`

Finally ssh into the container, containername.docker i.e. : `ssh root@box1.docker`