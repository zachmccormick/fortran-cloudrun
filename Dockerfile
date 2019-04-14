FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y gfortran make sqlite3 libsqlite3-dev nginx libfcgi-dev spawn-fcgi

ADD . /opt/lambda
WORKDIR /opt/lambda
RUN make

ADD nginx.conf /etc/nginx/sites-available/default.template
RUN service nginx stop

EXPOSE 80

CMD /opt/lambda/docker-entrypoint.sh
