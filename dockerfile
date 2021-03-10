FROM ubuntu:latest

ENV TZ=Europe/Rome
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY tcp.conf /etc/rsyslog.d/tcp.conf
COPY udp.conf /etc/rsyslog.d/udp.conf

RUN apt-get update && apt-get upgrade -y && apt-get install rsyslog -y && rm -rf /var/lib/apt/lists/*

EXPOSE 514/udp
EXPOSE 1514/tcp

CMD chown -R syslog:syslog /data/syslog && service rsyslog start && tail -F /var/log/syslog

VOLUME [ "/data/"]