FROM openjdk:8u121-jre

ADD run.sh /app/run.sh
ADD supervisord.conf /etc/supervisord.conf

RUN echo "deb http://packages.dotdeb.org jessie all" >>/etc/apt/sources.list \
 && echo "deb-src http://packages.dotdeb.org jessie all" >>/etc/apt/sources.list \
 && curl https://www.dotdeb.org/dotdeb.gpg > /tmp/dotdeb.gpg \
 && apt-key add /tmp/dotdeb.gpg \
 && apt-get update \
 && apt-get install -y nginx supervisor sudo \
 && apt-get install -y python-certbot-apache -t jessie-backports \
 && rm -rf /var/lib/apt/lists/* /tmp/* \
 && rm /etc/nginx/sites-enabled/default \
 && useradd -m app && echo "app:app" | chpasswd && adduser app sudo \
 && chown -R app /app \
 && chgrp adm /var/log && chmod g+w /var/log && chmod g+w /var/log/nginx \
 && chown app /var/log/nginx/* \
 && chgrp adm /var/log/supervisor && chmod g+w /var/log/supervisor \
 && adduser app adm \
 && echo 'app ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

ADD nginx.conf /etc/nginx/nginx.conf

USER app
WORKDIR /app

CMD ["./run.sh"]
