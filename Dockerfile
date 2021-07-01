FROM php:8.0-apache-buster

RUN a2enmod headers rewrite \
    && apt-get update && apt-get install --no-install-recommends -y \
      ghostscript \
      imagemagick \
      libbz2-dev \
      libicu-dev \
      libmagickcore-dev \
      libmagickwand-dev \
      libmcrypt-dev \
      libpq-dev \
      libxslt-dev \
      libzip-dev \
      unzip \
    && pecl channel-update pecl.php.net \
    && pecl install apcu imagick mcrypt mongodb redis \
    && docker-php-ext-enable apcu imagick mcrypt mongodb redis \
    && docker-php-ext-configure gd \
    && docker-php-ext-configure mysqli --with-mysqli=mysqlnd \
    && docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd \
    && docker-php-ext-install bcmath bz2 calendar exif gd intl mysqli opcache pdo_mysql pdo_pgsql sockets xsl zip \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && php -r "copy('https://getcomposer.org/composer.phar', 'composer.phar');" \
    && mv composer.phar /usr/local/bin/composer \
    && chmod +x /usr/local/bin/composer