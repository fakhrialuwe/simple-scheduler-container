FROM php:8.1-apache
WORKDIR /app
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
COPY . /app
RUN chown -R www-data.www-data /app && composer install --optimize-autoloader

ENTRYPOINT ["watch","-n","600","-t","sh start.sh"]
