FROM ubuntu:16.04

ENV GOSU_VERSION 1.9
RUN set -x \
    && apt-get update && apt-get install -y --no-install-recommends ca-certificates wget && rm -rf /var/lib/apt/lists/* \
    && dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
    && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch" \
    && wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc" \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
    && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true \
    && apt-get purge -y --auto-remove ca-certificates wget

COPY keyboard /etc/default/keyboard

RUN  apt-get update -y \
  && apt-get upgrade -y \
  && apt-get -f install \
  && apt-get install -y \
    wget \
    gconf2 \
    gconf-service \
    libgtk2.0-0 \
    libnotify4 \
    libxtst6 \
    libnss3 \
    python \
    gvfs-bin \
    xdg-utils \
    firefox \
    libgnome-keyring0 \
    libxss1 \
    libcanberra-gtk-module \
    libcanberra-gtk3-module \
    packagekit-gtk3-module \
    xserver-xorg-video-vmware

RUN  wget --quiet "https://release.gitkraken.com/linux/gitkraken-amd64.deb" -O /tmp/gitkraken-amd64.deb \
  && dpkg -i /tmp/gitkraken-amd64.deb \
  && rm /tmp/gitkraken-amd64.deb

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/bin/gitkraken"]

COPY docker-entrypoint.sh /
