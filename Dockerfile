FROM php:7.3-apache-buster

RUN a2enmod headers rewrite \
    && apt-get update && apt-get install --no-install-recommends -y \
      ghostscript \
      imagemagick \
      libicu-dev \
      libmagickcore-dev \
      libmagickwand-dev \
      libmcrypt-dev \
      libpq-dev \
      librabbitmq-dev \
      libxslt-dev \
      libzip-dev \
      unzip \
    && pecl channel-update pecl.php.net \
    && pecl install amqp apcu imagick mcrypt mongodb redis \
    && docker-php-ext-enable amqp apcu imagick mcrypt mongodb redis \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include \
    && docker-php-ext-configure mysqli --with-mysqli=mysqlnd \
    && docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd \
    && docker-php-ext-install bcmath bz2 calendar exif gd intl mysqli opcache pdo_mysql pdo_pgsql sockets xsl zip \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && php -r "copy('https://getcomposer.org/composer.phar', 'composer.phar');" \
    && mv composer.phar /usr/local/bin/composer \
    && chmod +x /usr/local/bin/composer
