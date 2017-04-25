########################

# cluster-redis-docker: centos 7 + openssh-server + systemd cluster
# Config: Update root.ssh/authorized_keys with your public key
# Build: docker build --rm -t csd .

# WARNING: This section not yet tested on OSX!
# export DOCKER0IP=$(ifconfig docker0 | grep "inet" | head -n1 | awk '{ print $2}' | cut -d: -f2)
# docker run --detach --name dns-gen --publish ${DOCKER0IP}:53:53/udp --volume /var/run/docker.sock:/var/run/docker.sock jderusse/dns-gen
# sudo sed -i "s/127.0.1.1/${DOCKER0IP}/g" /etc/resolv.conf
# To get init to work (and enable systemctl services):

# docker run -it --name box1 --rm --cap-add=SYS_ADMIN -e "container=docker" -v /sys/fs/cgroup:/sys/fs/cgroup:ro --tmpfs /run --tmpfs /run/lock csd

# 3 node cluster
# for i in 1 2 3; do docker run -d --name box${i} --rm --cap-add=SYS_ADMIN -e "container=docker" -v /sys/fs/cgroup:/sys/fs/cgroup:ro --tmpfs /run --tmpfs /run/lock csd ; done

# DNS masq
# docker run -d --name devdns -p 53:53/udp   -v /var/run/docker.sock:/var/run/docker.sock ruudud/devdns
# DNS Masq for cluster:
# for i in 1 2 3; do docker run -d --name box${i} --rm --cap-add=SYS_ADMIN -e "container=docker" -v /sys/fs/cgroup:/sys/fs/cgroup:ro --tmpfs /run --tmpfs /run/lock --dns=$(docker inspect -f "{{ .NetworkSettings.IPAddress }}" devdns) csd ; done

FROM centos:7
EXPOSE 22
# Packages
RUN yum update -y && yum install -y nmap-ncat vim wget lsof which sudo less

# RUN yum install -y openssh-server openssh-clients

# # # ssh configuration
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
