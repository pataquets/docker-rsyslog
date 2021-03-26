FROM pataquets/ubuntu:xenial

RUN \
  apt-key adv --keyserver hkp://hkps.pool.sks-keyservers.net --recv-keys 0F6DD8135234BF2B && \
  . /etc/lsb-release && \
  echo "deb http://ppa.launchpad.net/adiscon/v8-stable/ubuntu ${DISTRIB_CODENAME} main" | \
    tee /etc/apt/sources.list.d/rsyslog.list \
  && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends \
      rsyslog \
      rsyslog-elasticsearch \
      rsyslog-gnutls \
      rsyslog-imptcp \
      rsyslog-relp \
  && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

ENV RSYSLOG_DEBUG    "DebugOnDemand NoLogTimeStamp OutputTidToStderr"
ENV RSYSLOG_DEBUGLOG "/dev/null"

ADD files/etc/rsyslog.d/ /etc/rsyslog.d/

ENTRYPOINT [ "rsyslogd", "-n" ]
