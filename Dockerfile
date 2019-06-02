FROM alpine

# add openssh and clean
RUN apk add --update openssh \
    && rm  -rf /tmp/* /var/cache/apk/*

# copy sshd config
COPY docker/sshd_config /etc/ssh/

# copy entrypoint script
COPY docker/docker-entrypoint.sh /usr/local/bin

# copy root SSH key
COPY docker/keys/root/id_rsa.pub /root/.ssh/authorized_keys

# copy host identification keys
COPY docker/keys/host /etc/ssh

EXPOSE 22
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/usr/sbin/sshd","-D"]