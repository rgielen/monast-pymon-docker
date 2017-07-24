FROM ubuntu:zesty
MAINTAINER "Rene Gielen" <rgielen@apache.org>

ENV MONAST_HOME=/monast

RUN apt-get update && apt-get -y install python python-twisted python-zope.interface python-pip wget git unzip \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/* \
        && rm -rf /tmp/*

# RUN wget https://downloads.sourceforge.net/project/basicproperty/basicproperty/0.6.12a/basicproperty-0.6.12a.tar.gz?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fbasicproperty%2Ffiles%2F&ts=1500908704&use_mirror=netcologne
RUN wget https://downloads.sourceforge.net/project/basicproperty/basicproperty/0.6.12a/basicproperty-0.6.12a.tar.gz \
        && tar -xzf basicproperty-0.6.12a.tar.gz \
        && cd basicproperty-0.6.12a \
        && python setup.py install \
        && cd .. \
        && rm basicproperty-0.6.12a.tar.gz \
        && rm -rf basicproperty-0.6.12a

RUN wget https://downloads.sourceforge.net/project/starpy/starpy/1.0.0a13/starpy-1.0.0a13.tar.gz \
        && tar -xzf starpy-1.0.0a13.tar.gz \
        && cd starpy-1.0.0a13 \
        && python setup.py install \
        && cd .. \
        && rm starpy-1.0.0a13.tar.gz \
        && rm -rf starpy-1.0.0a13

RUN wget https://github.com/dagmoller/monast/archive/master.zip \
        && unzip master.zip \
        && mv monast-master/pymon / \
        && rm -rf monast-master \
        && echo "$PWD" \
        && rm master.zip
