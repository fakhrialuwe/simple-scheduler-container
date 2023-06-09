FROM php:8.1-alpine

# Install required system dependencies
RUN apk add --no-cache freetds-dev unixodbc-dev

# Install the SQLSRV extension
RUN pecl install sqlsrv pdo_sqlsrv && \
    docker-php-ext-enable sqlsrv pdo_sqlsrv

WORKDIR /app
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
COPY . /app
RUN chown -R www-data.www-data /app && composer install --optimize-autoloader

ENTRYPOINT ["watch","-n","360","-t","sh start.sh"]
