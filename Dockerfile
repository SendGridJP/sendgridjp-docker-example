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
RUN curl -sS https://getcomposer.org/installer | php
RUN mv /composer.phar /usr/local/bin/
#
# Get sample code
RUN mkdir /root/php
RUN git clone https://github.com/sendgridjp/sendgridjp-php-example
RUN mv /sendgridjp-php-example /root/php
RUN cd /root/php/sendgridjp-php-example;/usr/local/bin/composer.phar install

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
RUN git clone http://github.com/sendgridjp/sendgridjp-nodejs-example.git
RUN mv /sendgridjp-nodejs-example /root/nodejs
RUN cd /root/nodejs/sendgridjp-nodejs-example;npm install

#
# for python
RUN apt-get install -y python3.2
RUN mkdir /root/python
RUN curl -O https://raw.github.com/pypa/pip/master/contrib/get-pip.py
RUN mv /get-pip.py /root/python
RUN python3.2 /root/python/get-pip.py
RUN pip install sendgrid
#
# Get sample code
RUN git clone http://github.com/sendgridjp/sendgridjp-python-example.git
RUN mv /sendgridjp-python-example /root/python

#
# for Ruby
RUN curl -sSL https://get.rvm.io | bash -s stable --ruby
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"
#RUN /bin/bash /usr/local/rvm/scripts/rvm;gem install bundler
#RUN source /usr/local/rvm/scripts/rvm
#RUN apt-get install -y python-software-properties
#RUN add-apt-repository -y ppa:brightbox/ruby-ng
#RUN apt-get update
#RUN apt-get install -y ruby2.1
#ADD files/.gemrc /root/.gemrc
#RUN source /usr/local/rvm/scripts/rvm;gem install bundler
#
# Get sample code
RUN mkdir /root/ruby
RUN git clone http://github.com/sendgridjp/sendgridjp-ruby-example.git
RUN mv /sendgridjp-ruby-example /root/ruby
RUN cd /root/ruby/sendgridjp-ruby-example ; /bin/bash -l -c "bundle install"
