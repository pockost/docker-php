FROM php:7.4-cli-buster

COPY docker-php-entrypoint /usr/local/bin/
COPY docker-php-ini-configure /docker-entrypoint.d/
COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN apt-get update && apt-get install --no-install-recommends -y \
      ghostscript \
      imagemagick \
      libicu-dev \
      libmagickcore-dev \
      libmagickwand-dev \
      libpq-dev \
      libxslt-dev \
      libzip-dev \
      unzip \
    && pecl channel-update pecl.php.net \
    && pecl install apcu imagick redis \
    && docker-php-ext-enable apcu imagick redis \
    && docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include \
    && docker-php-ext-configure mysqli --with-mysqli=mysqlnd \
    && docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd \
    && docker-php-ext-install bcmath bz2 calendar exif gd intl mysqli opcache pdo_mysql pdo_pgsql xsl zip \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/*