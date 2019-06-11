FROM php:7.2-apache-stretch

RUN a2enmod rewrite \
    && apt-get update && apt-get install --no-install-recommends -y \
      libicu-dev \
      libmagickcore-dev \
      libmagickwand-dev \
      libxslt-dev \
      unzip \
    && pecl install redis xdebug imagick \
    && docker-php-ext-enable redis xdebug imagick \
    && docker-php-ext-configure intl --with-icu-dir=/usr \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include \
    && docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd \
    && docker-php-ext-configure mysqli --with-mysqli=mysqlnd \
    && docker-php-ext-install zip calendar bcmath bz2 exif opcache xsl intl gd pdo_mysql mysqli \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && php -r "copy('https://getcomposer.org/composer.phar', 'composer.phar');" \
    && mv composer.phar /usr/local/bin/composer \
    && chmod +x /usr/local/bin/composer