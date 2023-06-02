# Extensions

RUN docker-php-ext-install zip
RUN docker-php-ext-install gd
RUN docker-php-ext-enable zip
RUN docker-php-ext-enable gd
libapache2-mod-php mysql gd