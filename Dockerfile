########################

# centos-ssh-testbed: centos 7 + openssh-server
# Config: Update root.ssh/authorized_keys with your public key
# Build: docker build --rm -t cst .

# WARNING: This section not yet tested on OSX!
# export DOCKER0IP=$(ifconfig docker0 | grep "inet" | head -n1 | awk '{ print $2}' | cut -d: -f2)
# docker run --detach --name dns-gen --publish ${DOCKER0IP}:53:53/udp --volume /var/run/docker.sock:/var/run/docker.sock jderusse/dns-gen
# echo "nameserver $(echo $DOCKER0IP)" | sudo tee --append /etc/resolvconf/resolv.conf.d/head
# sudo resolvconf -u

# docker run --rm -d --name box1 cst

FROM centos:7
EXPOSE 22
# Packages
RUN yum update -y && yum install -y nmap-ncat vim wget lsof which

# openssh-server openssh-clients

# ssh configuration - if we want it
# RUN sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config
# RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
# RUN sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config
# RUN ssh-keygen -q -P "" -t rsa -f /etc/ssh/ssh_host_rsa_key

# COPY root.ssh /root/.ssh
# RUN chmod 0600 /root/.ssh/*

# entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
CMD ["/entrypoint.sh"]