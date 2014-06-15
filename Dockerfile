FROM centos

MAINTAINER Naoki AINOYA <ainonic@gmail.com>

# setup remi repository
RUN yum -y install wget tar
RUN wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN wget http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
RUN curl -O http://rpms.famillecollet.com/RPM-GPG-KEY-remi; rpm --import RPM-GPG-KEY-remi
RUN rpm -Uvh remi-release-6*.rpm epel-release-6*.rpm
RUN yum -y update
RUN yum -y upgrade
RUN yum -y install python-setuptools python-devel git gcc java-1.7.0-openjdk
RUN easy_install pip pyyaml

# setup ssh server

RUN yum -y install -y openssh-server
RUN mkdir /var/run/sshd
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config
RUN sed -ri 's/PermitRootLogin without-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
RUN echo 'root:sixpack' | chpasswd

# setup redis
ENV REDIS_RELEASE 2.8.9

RUN mkdir -p /etc/redis
RUN mkdir -p /var/log/redis
RUN mkdir -p /var/lib/redis/6379
RUN wget http://download.redis.io/releases/redis-$REDIS_RELEASE.tar.gz
RUN tar -zxf redis-$REDIS_RELEASE.tar.gz
RUN \
    cd redis-$REDIS_RELEASE && \
    /usr/bin/make install && \
    cp utils/redis_init_script /etc/init.d/redis && \
    cd .. && \
    rm -rf redis-$REDIS_RELEASE

ADD template/redis.conf /etc/redis/6379.conf

# setup supervisord

RUN pip install supervisor
RUN mkdir -p /etc/supervisord.d/
RUN mkdir -p /var/log/supervisor
ADD template/supervisord.conf /etc/supervisord.conf
ADD template/supervisord.d/sixpack-web.ini /etc/supervisord.d/sixpack-web.ini
ADD template/supervisord.d/sixpack.ini /etc/supervisord.d/sixpack.ini

# setup sixpack

RUN mkdir -p /home/sixpack
WORKDIR /home/sixpack
RUN git clone https://github.com/seatgeek/sixpack

WORKDIR /home/sixpack/sixpack
RUN pip install -r requirements.txt

ADD scripts/init_service.sh /home/sixpack/init_service.sh

# start server
EXPOSE 22 5000 5001

WORKDIR /home/sixpack
CMD sh ./init_service.sh
CMD service sshd start && service redis start && supervisord -c /etc/supervisord.conf


