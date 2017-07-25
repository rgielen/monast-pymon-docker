FROM ubuntu:zesty
MAINTAINER "Rene Gielen" <rgielen@apache.org>

RUN apt-get update && apt-get -y install python python-twisted python-zope.interface python-pip wget unzip \
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

ENV BIND_HOST=0.0.0.0
ENV BIND_PORT=5039
ENV ASTERISK_HOST=localhost
ENV ASTERISK_PORT=5038
ENV AMI_USERNAME=admin
ENV AMI_PASSWORD=admin
ENV DEFAULT_CONTEXT=default
ENV TRANSFER_CONTEXT=default
ENV MEETME_CONTEXT=default
ENV USER_ADMIN_SECRET=admin
ENV USER_AGENT_SECRET=agent

RUN echo '[global]\n\
bind_host = '$BIND_HOST'\n\
bind_port = '$BIND_PORT'\n\
auth_required = false\n\
\n\
[server: Asterisk]\n\
hostname = '$ASTERISK_HOST'\n\
hostport = '$ASTERISK_PORT'\n\
username = '$AMI_USERNAME'\n\
password = '$AMI_PASSWORD'\n\
default_context = '$DEFAULT_CONTEXT'\n\
transfer_context = '$TRANSFER_CONTEXT'\n\
meetme_context = '$MEETME_CONTEXT'\n\
meetme_prefix  = \n\
\n\
[peers]\n\
sortby = callerid\n\
default = show\n\
\n\
[meetmes]\n\
default = show\n\
\n\
[queues]\n\
default = show\n\
\n\
[user: admin]\n\
secret  = '$USER_ADMIN_SECRET'\n\
roles   = originate,queue,command,spy\n\
servers = ALL\n\
\n\
[user: agent]\n\
secret  = '$USER_AGENT_SECRET'\n\
roles   = originate,queue,spy\n\
servers = ALL\n\
\n\
[user: demo]\n\
secret  = \n\
roles   = \n\
servers = ALL\n\
\n## END' \
>> /etc/monast.conf

EXPOSE ${BIND_PORT}
ENTRYPOINT ["/pymon/monast.py"]
