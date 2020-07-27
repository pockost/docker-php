FROM php:5.5-apache

COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN printf "deb http://archive.debian.org/debian/ jessie main\ndeb-src http://archive.debian.org/debian/ jessie main\ndeb http://security.debian.org jessie/updates main\ndeb-src http://security.debian.org jessie/updates main" > /etc/apt/sources.list \
    && a2enmod rewrite \
    && apt-get update && apt-get install --no-install-recommends --force-yes -y \
      ghostscript \
      imagemagick \
      libicu-dev \
      libmagickcore-dev \
      libmagickwand-dev \
      libmcrypt-dev \
      libpq-dev \
      libxslt-dev \
      unzip \
    && pecl install imagick redis-4.3.0 xdebug-2.5.5 \
    && docker-php-ext-enable imagick redis xdebug \
    && docker-php-ext-configure intl --with-icu-dir=/usr \
    && docker-php-ext-configure mysqli --with-mysqli=mysqlnd \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include \
    && docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd \
    && docker-php-ext-install bcmath bz2 calendar exif gd intl mcrypt mysql mysqli opcache pdo_mysql pdo_pgsql xsl zip \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/*
