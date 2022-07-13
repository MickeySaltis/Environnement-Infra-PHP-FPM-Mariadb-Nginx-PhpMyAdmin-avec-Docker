FROM php:8.0.0-fpm-alpine
# Telechargement de PHP 8/Alpine

# Execution commande Conteneur. Instalation packages sans etre mit en cache localement.
RUN set -xe && apk add --no-cache --update \ 
	bash \ 
	nano \
	wget \
	zip \
	unzip \
	mariadb-client \
	ca-certificates \
	curl \
	git \
	openssh \
	make \
	coreutils \
	shadow \
	libwebp \
	libwebp-tools \
	nodejs \
	npm \
	openssl-dev \
	grep \
	sed \
	autoconf \
	gcc \
	g++ \
	zlib-dev \
	inotify-tools \
	rsync \
	pkgconf \
	re2c \
	libzip-dev \
	libpng-dev \
	imagemagick-dev \
	ssmtp \
	gmp-dev \
	imagemagick6-libs 	 \
	sudo \
	busybox-suid

# Instalation extensions PHP PDO/MySQL 
RUN docker-php-ext-install opcache mysqli pdo pdo_mysql zip gd bcmath

# Execution commande Conteneur. Instalation packages/extensions
RUN set -xe \
	&& apk add --update \
	icu \
	&& apk add --no-cache --virtual .php-deps \
	make \
	&& apk add --no-cache --virtual .build-deps \
	$PHPIZE_DEPS \
	zlib-dev \
	icu-dev \
	g++ \
	&& docker-php-ext-configure intl \
	&& docker-php-ext-install \
	intl \
	&& docker-php-ext-enable intl \
	&& { find /usr/local/lib -type f -print0 | xargs -0r strip --strip-all -p 2>/dev/null || true; } \
	&& apk del .build-deps \
	&& rm -rf /tmp/* /usr/local/lib/php/doc/* /var/cache/apk/*

# Instalation extension Redis
RUN pecl install -o -f redis \
	&&  rm -rf /tmp/pear \
	&&  docker-php-ext-enable redis

# Instalation extension Xdebug
RUN pecl install xdebug \
	&& docker-php-ext-enable xdebug

# Copier
COPY opcache.ini /usr/local/etc/php/conf.d/opcache.ini
COPY opcache.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
COPY php.ini /usr/local/etc/php/conf.d/php.ini

# Instalation de Imagick
RUN set -xe \
	&& git clone https://github.com/Imagick/imagick \
	&& cd imagick \
	&& git checkout master && git pull \
	&& phpize && ./configure && make && make install \
	&& cd .. && rm -Rf imagick \
	&& docker-php-ext-enable imagick 

# Instalation de Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Change de répertoire
WORKDIR /var/www/html

# Variables Environnement
ENV USER=MatthieuS
ENV UID=1000
ENV USER_ID=1000
ENV GID=1000

# Mise a jour des autorisations de fichiers 
ADD ./docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Variables
ARG USER=MatthieuS
ENV HOME /home/$USER

# Execution commande sudo sans mdp
RUN adduser -D $USER \
	&& echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER \
	&& chmod 0440 /etc/sudoers.d/$USER

# Ajouter au groupe
RUN adduser $USER www-data

# Utilisateur pouvant interagir avec l'image
USER $USER

# Execution au lancement
ENTRYPOINT ["docker-entrypoint.sh"]
CMD [ "php-fpm" ]