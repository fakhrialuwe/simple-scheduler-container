FROM php:8.1-apache
ENV ACCEPT_EULA=Y

# Install PDO dependencies
RUN apt update && apt install -y gnupg2
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt update
RUN ACCEPT_EULA=Y apt -y --no-install-recommends install msodbcsql17 unixodbc-dev
RUN curl -o /usr/lib/x86_64-linux-gnu/libltdl.la https://www.apt-browse.org/browse/debian/jessie/main/amd64/libltdl-dev/2.4.2-1.11+b1/file/usr/lib/x86_64-linux-gnu/libltdl.la
RUN pecl install sqlsrv pdo_sqlsrv
RUN docker-php-ext-enable sqlsrv pdo_sqlsrv

WORKDIR /app
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
COPY . /app
RUN chown -R www-data.www-data /app && composer install --optimize-autoloader

ENTRYPOINT ["watch","-n","360","-t","sh start.sh"]
