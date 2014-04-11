# sendgridjp-example
#
# VERSION	1.0
#
# use the ubuntu base image provided by dotCloud
#
FROM ubuntu
MAINTAINER awwa, awwa500@gmail.com

#
# make sure the package repository is up to date
#
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update

#
# install ssh for maintainance
#
RUN apt-get install -y openssh-server
RUN mkdir -p /var/run/sshd
RUN echo root:password | chpasswd
RUN echo 'rootpass ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

#
# expose ssh port
#
EXPOSE 22

#
# install modules

#
# for general
#
RUN apt-get install -y language-pack-ja
RUN apt-get install -y git

#
# for PHP
RUN apt-get install -y php5 curl libcurl3 php5-curl
RUN curl -sS https://getcomposer.org/installer | php
RUN mv /composer.phar /usr/local/bin/
RUN mkdir /root/php
RUN git clone https://github.com/awwa/sendgridjp-php-example
RUN mv /sendgridjp-php-example /root/php
RUN cd /root/php/sendgridjp-php-example;/usr/local/bin/composer.phar install

