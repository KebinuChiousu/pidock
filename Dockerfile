FROM scratch

USER root
ADD root.tar /
ADD deb/ /deb/

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN=true

RUN dpkg -i /deb/volian-archive-keyring.deb && \
    dpkg -i /deb/volian-archive-nala.deb && \
    apt-get update && apt-get install -y nala-legacy && \ 
    nala update && \
    nala install -y initramfs-tools open-iscsi vim && \
    nala upgrade -y

ARG PI_PASSWORD
RUN echo "pi:${PI_PASSWORD}" | chpasswd

ADD root-overlay /
RUN chown -R pi /home/pi
