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
#
RUN apt-get install -y php5 curl libcurl3 php5-curl
WORKDIR /usr/local/bin 
RUN curl -sS https://getcomposer.org/installer | php
#
# Get sample code
RUN mkdir /root/php
WORKDIR /root/php 
RUN git clone https://github.com/sendgridjp/sendgridjp-php-example
WORKDIR /root/php/sendgridjp-php-example 
RUN /usr/local/bin/composer.phar install

#
# for node.js
RUN apt-get update
RUN apt-get install -y python-software-properties
RUN add-apt-repository -y ppa:chris-lea/node.js
RUN apt-get update
RUN apt-get install -y nodejs
#
# Get sample code
RUN mkdir /root/nodejs
WORKDIR /root/nodejs 
RUN git clone http://github.com/sendgridjp/sendgridjp-nodejs-example.git
#RUN cd /root/nodejs/sendgridjp-nodejs-example;npm install
WORKDIR /root/nodejs/sendgridjp-nodejs-example 
RUN npm install

#
# for python
RUN apt-get install -y python3.2
RUN mkdir /root/python
WORKDIR /root/python 
RUN curl -L -O https://raw.github.com/pypa/pip/master/contrib/get-pip.py
RUN python3.2 /root/python/get-pip.py
RUN pip install sendgrid
#
# Get sample code
WORKDIR /root/python 
RUN git clone http://github.com/sendgridjp/sendgridjp-python-example.git

#
# for Ruby
RUN curl -sSL https://get.rvm.io | bash -s stable --ruby
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"
#
# Get sample code
RUN mkdir /root/ruby
WORKDIR /root/ruby 
RUN git clone http://github.com/sendgridjp/sendgridjp-ruby-example.git
WORKDIR /root/ruby/sendgridjp-ruby-example 
RUN /bin/bash -l -c "bundle install"

#
# for Go
RUN wget https://go.googlecode.com/files/go1.2.1.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf go1.2.1.linux-amd64.tar.gz
RUN echo 'export PATH=$PATH:/usr/local/go/bin' >> /etc/profile
RUN echo 'export GOROOT=/usr/local/go' >> /root/.profile
#
# Get sample code
RUN mkdir /root/go
WORKDIR /root/go 
RUN git clone http://github.com/sendgridjp/sendgridjp-go-example.git
RUN echo 'export GOPATH=/root/go/sendgridjp-go-example' >> /root/.profile
ENV PATH $PATH:/usr/local/go/bin
ENV GOROOT /usr/local/go
ENV GOPATH /root/go/sendgridjp-go-example

