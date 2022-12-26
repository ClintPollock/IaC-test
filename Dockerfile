# don't use tag for base image
FROM alpine

COPY dummy.txt /dummy.txt

COPY insecure-config.txt /config.txt
COPY aws-credentials.txt /etc/credentials.txt

COPY id_rsa id_rsa.pub /root/

# Test for privilege escalating unix permissions
COPY bad-script.sh /bin/ok-script.sh
COPY bad-script.sh /bin/bad-script.sh
COPY bad-script.sh /bin/bad2-script.sh
RUN chmod +x    /bin/*-script.sh
RUN chmod u+s  /bin/bad-script.sh
RUN chmod g+s  /bin/bad2-script.sh

# Test for detection of known vulns
RUN apk add curl tar
RUN curl https://archive.apache.org/dist/logging/log4j/2.0.1/apache-log4j-2.0.1-bin.tar.gz -o  /apache-log4j-2.0.1-bin.tar.gz
RUN ls -l /
RUN cd / && tar xzvf /apache-log4j-2.0.1-bin.tar.gz
RUN ls -l /

CMD ["sleep 1"]
