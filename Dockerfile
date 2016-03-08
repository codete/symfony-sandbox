FROM codete/php

MAINTAINER Codete <docker@codete.com>

RUN apt-get update && \
    apt-get install -y php5-mysql && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV SYMFONY__ENV dev

COPY . /var/www

WORKDIR /var/www

RUN mkdir /var/tmp/symfony && \
    rm web/app_dev.php && \
    rm web/config.php

VOLUME ["/var/www"]

CMD service php5-fpm start && tail -f /var/log/php*fpm.log | ccze -A
