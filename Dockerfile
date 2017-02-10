#########################
#
# centos-ssh-testbed: centos 7 + openssh-server
#
# Build: docker build --rm -t cst .
#
# each container will need it's own unique front-door port (i.e. 2222)
# docker run -p 2222:22 --rm -it --name box1 cst

FROM centos:7

# Packages
RUN yum update -y && yum install -y nmap-ncat vim openssh-server openssh-clients wget lsof which

# ssh configuration
RUN sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config
RUN ssh-keygen -q -P "" -t rsa -f /etc/ssh/ssh_host_rsa_key

COPY root.ssh /root/.ssh
RUN chmod 0600 /root/.ssh/*

# entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
CMD ["/entrypoint.sh"]