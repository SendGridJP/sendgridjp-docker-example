# sendgridjp-example
#
# VERSION	1.1
#
# use the ubuntu base image provided by dotCloud
#
FROM dockerfile/ubuntu
MAINTAINER awwa, awwa500@gmail.com

#
# make sure the package repository is up to date
#
RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe" > /etc/apt/sources.list
RUN apt-get update

#
# install ssh for maintainance
#
RUN apt-get install -y openssh-client
RUN apt-get install -y ssh-import-id openssh-server
RUN mkdir -p /var/run/sshd
RUN echo root:password | chpasswd
RUN echo 'rootpass ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config
RUN sed -e "s/PermitRootLogin without-password/PermitRootLogin yes/g" /etc/ssh/sshd_config > /etc/ssh/sshd_config
#
# expose ssh port
#
EXPOSE 22

#
# install modules

#
# for Japanese
#
RUN apt-get install -y language-pack-ja
RUN echo ":set encoding=utf-8" >> /root/.vimrc
RUN echo ":set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8" >> /root/.vimrc
RUN echo "export LESSCHARSET=utf-8" >> /root/.profile

#
# for general
#
RUN apt-get install -y perl
RUN apt-get install -y libswitch-perl
RUN apt-get install -y perl-modules
RUN apt-get install -y liberror-perl
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
ADD ./.env /root/php/sendgridjp-php-example/.env

#
# for node.js
RUN apt-get install -y g++ build-essential
RUN mkdir /root/nodejs
WORKDIR /root/nodejs
RUN wget http://nodejs.org/dist/v0.11.13/node-v0.11.13.tar.gz
RUN tar zxvf node-v0.11.13.tar.gz
WORKDIR /root/nodejs/node-v0.11.13
RUN ./configure
RUN make install
#
# Get sample code
WORKDIR /root/nodejs
RUN git clone http://github.com/sendgridjp/sendgridjp-nodejs-example.git
WORKDIR /root/nodejs/sendgridjp-nodejs-example
RUN npm install
ADD ./.env /root/nodejs/sendgridjp-nodejs-example/.env

#
# for python
WORKDIR /root
RUN mkdir /root/python
WORKDIR /root/python
RUN apt-get install -y --force-yes libssl1.0.0/trusty libssl-dev/trusty openssl/trusty #zlib1g-dev libssl-dev
RUN apt-get install -y zlib1g-dev libssl-dev/trusty
RUN wget https://www.python.org/ftp/python/3.2.5/Python-3.2.5.tgz
RUN tar xvzf Python-3.2.5.tgz
WORKDIR /root/python/Python-3.2.5
RUN ./configure --with-zlib
RUN make install
WORKDIR /root/python
RUN curl -L -O https://raw.github.com/pypa/pip/master/contrib/get-pip.py
RUN /usr/local/bin/python3.2 /root/python/get-pip.py
#RUN python /root/python/get-pip.py
WORKDIR /root/python/sendgridjp-python-example
RUN pip install sendgrid
#
# Get sample code
WORKDIR /root/python
RUN git clone http://github.com/sendgridjp/sendgridjp-python-example.git
WORKDIR /root/python/sendgridjp-python-example
RUN pip install sendgrid
RUN pip install dotenv
ADD ./.env /root/python/sendgridjp-python-example/.env

#
# for Ruby
RUN mkdir /root/ruby
WORKDIR /root/ruby
RUN wget http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.2.tar.gz
RUN tar zxvf ruby-2.1.2.tar.gz
WORKDIR /root/ruby/ruby-2.1.2
RUN ./configure
RUN make install
#RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"
RUN gem install bundler
#
# Get sample code
WORKDIR /root/ruby
RUN git clone http://github.com/sendgridjp/sendgridjp-ruby-example.git
WORKDIR /root/ruby/sendgridjp-ruby-example
RUN /bin/bash -l -c "bundle install"
ADD ./.env /root/ruby/sendgridjp-ruby-example/.env

#
# for Go
WORKDIR /root
RUN wget https://go.googlecode.com/files/go1.2.1.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf go1.2.1.linux-amd64.tar.gz
RUN rm go1.2.1.linux-amd64.tar.gz
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
WORKDIR /root/go/sendgridjp-go-example
RUN go get github.com/sendgrid/sendgrid-go
RUN go get github.com/joho/godotenv
RUN go install main
ADD ./.env /root/go/sendgridjp-go-example/.env

#
# for Java
WORKDIR /root
RUN \
  echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections && \
  apt-get install -y python-software-properties && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java7-installer
RUN apt-get install -y gradle
#ENV JAVA_HOME /usr/lib/jvm/java-7-oracle
#RUN echo 'export JAVA_HOME=/usr/lib/jvm/java-7-oracle' >> /root/.profile
RUN ln -s /usr/lib/jvm/java-7-oracle /usr/lib/jvm/default-java
#
# Get sample code
RUN mkdir /root/java
WORKDIR /root/java
RUN git clone http://github.com/sendgridjp/sendgridjp-java-example.git
WORKDIR /root/java/sendgridjp-java-example
RUN gradle build
ADD ./.env /root/java/sendgridjp-java-example/.env
