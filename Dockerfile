FROM ruby:2.4.1

RUN apt-get update
RUN apt-get --assume-yes install dnsutils

RUN gem install cassandra-web

ADD entrypoint.sh /

RUN chmod a+x /entrypoint.sh

EXPOSE 3000

ENTRYPOINT ["/entrypoint.sh"]