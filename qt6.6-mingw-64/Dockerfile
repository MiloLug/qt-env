FROM ubuntu

ARG AQT_VERSION="3.1.7"
ARG AQT_SHA256=b6ca0afb5e54e692b63a24e3db98bbac34927545e867c51ba71a4ea84eeae446

ARG QT_VERSION=6.6.1
ARG QT_PATH=C:\\Qt

ENV DEBIAN_FRONTEND=noninteractive \
    DEBCONF_NONINTERACTIVE_SEEN=true \
    QT_VERSION=${QT_VERSION} \
    AQT_VERSION=${AQT_VERSION} \
    AQT_SHA256=${AQT_SHA256} \
    QT_PATH=${QT_PATH} \
    WINEDEBUG=-all


# Install required packages, add group & user + sudo
RUN apt update && apt install -y --no-install-suggests --no-install-recommends locales sudo ca-certificates wine64 && \
    sudo apt -qq clean && rm -rf /var/lib/apt/lists/* && \
    groupadd -r user && useradd -m -g user user && \
    echo 'user ALL=NOPASSWD: ALL' > /etc/sudoers.d/user && \
    mkdir /scripts && chmod 777 /scripts


# Reconfigure locale
RUN locale-gen en_US.UTF-8 && dpkg-reconfigure locales


USER user
WORKDIR /home/user
ENV HOME /home/user

COPY get_qt.sh apt_env /scripts/
RUN sudo chmod +x /scripts/*.sh && /scripts/get_qt.sh

COPY install_additional.sh /scripts/
RUN sudo chmod +x /scripts/*.sh && /scripts/install_additional.sh

COPY finish_wine_init.sh /scripts/
RUN sudo chmod +x /scripts/*.sh && /scripts/finish_wine_init.sh

