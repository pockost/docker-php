FROM php:8.0-fpm-buster

COPY docker-php-entrypoint /usr/local/bin/
COPY docker-php-ini-configure /docker-entrypoint.d/
COPY docker-configure-session /docker-entrypoint.d/
COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN  apt-get update && apt-get install --no-install-recommends -y \
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
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-configure mysqli --with-mysqli \
    && docker-php-ext-configure pdo_mysql --with-pdo-mysql \
    && docker-php-ext-install bcmath bz2 calendar exif gd intl mysqli opcache pdo_mysql pdo_pgsql sockets xsl zip \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/*
