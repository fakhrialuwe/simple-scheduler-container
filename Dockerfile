FROM php:8.0

# Install required system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    unixodbc \
    unixodbc-dev

# Import the Microsoft GPG key
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -

# Register the Microsoft SQL Server repository
RUN curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list

# Update the package lists
RUN apt-get update

# Install the SQL Server drivers and ODBC driver
RUN ACCEPT_EULA=Y apt-get install -y msodbcsql17 mssql-tools unixodbc-dev

# Install the SQLSRV and PDO_SQLSRV extensions
RUN pecl install sqlsrv pdo_sqlsrv && \
    docker-php-ext-enable sqlsrv pdo_sqlsrv

WORKDIR /app
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
COPY . /app
RUN chown -R www-data.www-data /app && composer install --optimize-autoloader

ENTRYPOINT ["watch","-n","360","-t","sh start.sh"]
