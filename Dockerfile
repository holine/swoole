FROM php:alpine as build
RUN apk add openssl-dev 
RUN pecl bundle -d /usr/src/php/ext swoole
RUN docker-php-ext-configure swoole --enable-openssl --enable-sockets --enable-mysqlnd --enable-http2
RUN docker-php-ext-install swoole

FROM php:alpine
RUN apk add libstdc++ && rm -rf /usr/local/lib/php/extensions /usr/local/etc/php/conf.d
COPY --from=build /usr/local/lib/php/extensions /usr/local/lib/php/extensions
COPY --from=build /usr/local/etc/php/conf.d /usr/local/etc/php/conf.d