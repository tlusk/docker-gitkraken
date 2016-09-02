FROM centos:7

ENV GOSU_VERSION 1.9
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
  && curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.9/gosu-amd64" \
  && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.9/gosu-amd64.asc" \
  && gpg --verify /usr/local/bin/gosu.asc \
  && rm /usr/local/bin/gosu.asc \
  && rm -r /root/.gnupg/ \
  && chmod +x /usr/local/bin/gosu

RUN yum update -y \
  && yum install -y \
    wget \
    dbus-x11 \
    GConf2 \
    dconf \
    dconf-editor \
    gtk2 \
    libnotify \
    libXtst \
    nss \
    python \
    gvfs \
    xdg-utils \
    firefox \
    gnome-keyring \
    libgnome-keyring \
    libXScrnSaver \
    libcanberra-gtk2 \
    libcanberra-gtk3 \
    PackageKit-gtk3-module \
    xorg-x11-drv-vmware

RUN  wget --quiet "https://release.gitkraken.com/linux/gitkraken-amd64.tar.gz" -O /tmp/gitkraken-amd64.tar.gz \
  && tar -xf /tmp/gitkraken-amd64.tar.gz -C /opt \
  && mv /opt/GitKraken /opt/gitkraken \
  && rm /tmp/gitkraken-amd64.tar.gz

ENTRYPOINT ["/opt/gitkraken/docker-entrypoint.sh"]
CMD ["/opt/gitkraken/gitkraken"]

COPY docker-entrypoint.sh /opt/gitkraken/docker-entrypoint.sh