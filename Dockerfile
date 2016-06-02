FROM codete/php5

MAINTAINER Codete <docker@codete.com>

ENV SYMFONY__ENV dev

COPY . /var/www

WORKDIR /var/www

RUN rm web/app_dev.php && \
    rm web/config.php && \
    usermod -u 1000 www-data && \
    chown -R www-data:www-data /var/www/app/cache && \
    chown -R www-data:www-data /var/www/app/logs

VOLUME ["/var/www"]

CMD service php5-fpm start && tail -f /var/log/php*fpm.log | ccze -A
