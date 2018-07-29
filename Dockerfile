
FROM    ubuntu:16.04
LABEL   Name=acestream-proxy Version=0.0.1

RUN apt-get update -y
# General dependencies
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    # ca-certificates \
    # supervisor \
    unzip  \
    wget
# Acestream dependencies
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    libpython2.7-dev \
    python-apsw \
    python-m2crypto \
    python-apsw
# AceProxy dependencies
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    ffmpeg \
    python-pip

RUN pip install -U psutil
RUN pip install -U gevent

RUN cd /tmp/ && wget "http://dl.acestream.org/linux/acestream_3.1.16_ubuntu_16.04_x86_64.tar.gz"
RUN cd /tmp/ && tar zxvf acestream_3.1.16_ubuntu_16.04_x86_64.tar.gz
RUN cd /tmp/ && mv acestream_3.1.16_ubuntu_16.04_x86_64 /opt/acestream

# RUN adduser --disabled-password --gecos "" tv
RUN cd /tmp/ && wget https://github.com/pepsik-kiev/HTTPAceProxy/archive/master.zip -O master.zip
RUN cd /tmp/ && unzip master.zip -d /opt

ADD aceconfig.py /opt/HTTPAceProxy-master
ADD start.sh /start.sh
RUN chmod +x /start.sh
EXPOSE 8000

CMD /start.sh
