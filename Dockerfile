FROM openjdk:8u222-jre-slim-buster

ADD run.sh /app/run.sh
ADD supervisord.conf /etc/supervisord.conf

RUN apt-get update \
 && apt-get install -y nginx supervisor python-certbot-apache \
 && rm -rf /var/lib/apt/lists/* /tmp/* \
 && rm /etc/nginx/sites-enabled/default

ADD nginx.conf /etc/nginx/nginx.conf

CMD ["/app/run.sh"]
