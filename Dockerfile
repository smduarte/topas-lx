FROM ubuntu:18.04 as temp_files_eclipse

WORKDIR /tmp

ENV ECLIPSE eclipse-java-2022-03-R-linux-gtk-x86_64.tar.gz

RUN apt-get update && apt-get install -y wget && \
    wget https://ftp.snt.utwente.nl/pub/software/eclipse/technology/epp/downloads/release/2022-03/R/$ECLIPSE && \
	tar xvfz $ECLIPSE



#------------------------------------------------------
FROM ubuntu:18.04
ENV DEBIAN_FRONTEND noninteractive

# Install git, supervisor, VNC, & X11 packages
RUN set -ex; \
    apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates\
      software-properties-common \
      wget curl \
      net-tools \
      socat \
      supervisor \
      lxde \
      file-roller \
      sudo iputils-ping iproute2 socat x11-xkb-utils \
    && apt autoclean -y \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# TEXT EDITORS
RUN apt-get update && apt-get install -y gedit kate vim joe


# JDK 11
RUN apt-get update && apt-get install -y locales ca-certificates openjdk-11-jdk

# Free Pascal
RUN apt-get update && apt-get install -y lazarus

# Python3
RUN apt-get update && apt-get install -y python3 idle3

# C++
RUN apt-get update && apt-get install -y build-essential

# Code::blocks
RUN add-apt-repository ppa:fuscated/codeblocks-nightly && \
	apt-get update && apt-get install -y codeblocks


RUN apt-get update && apt-get install -y fonts-liberation && \
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb 

COPY --from=temp_files_eclipse /tmp/eclipse /opt/eclipse/
#COPY --from=temp_files_intellij /tmp/idea /opt/idea/

# tini for subreap
ARG TINI_VERSION=v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /bin/tini
RUN chmod +x /bin/tini

COPY startup.sh /
RUN groupadd docker && \
    chmod a+x /startup.sh
 
COPY desktop-items-0.conf /tmp

RUN locale-gen pt_PT.UTF-8 en_US.UTF-8
COPY ./supervisor/* /etc/supervisor/conf.d/

ENV LANG pt_PT.UTF-8
ENV LANGUAGE en_USA
ENV LC_CTYPE pt_PT.UTF-8

ENV USER=topas

ENV HOME /home/$USER

ENV UID 1000
ENV GID 1001

RUN useradd $USER -m --home $HOME -u $UID --groups docker,sudo --shell /bin/bash && (echo "topas:topas" | chpasswd)

#USER topas
#WORKDIR /home/topas
CMD /startup.sh
