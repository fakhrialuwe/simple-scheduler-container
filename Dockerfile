FROM mcr.microsoft.com/dotnet/core/runtime:3.1 AS base

RUN apk add --no-cache php7.4-pdo_odbc php7.4-sqlsrv php7.4-pdo_sqlsrv

COPY odbc.ini /etc/odbc.ini
COPY odbcinst.ini /etc/odbcinst.ini

WORKDIR /app
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
COPY . /app
RUN chown -R www-data.www-data /app && composer install --optimize-autoloader

ENTRYPOINT ["watch","-n","360","-t","sh start.sh"]
