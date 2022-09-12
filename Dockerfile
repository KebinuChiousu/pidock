FROM scratch

USER root
ADD root.tar /
RUN apt-get update && apt-get install -y initramfs-tools open-iscsi vim

ARG PI_PASSWORD
RUN echo "pi:${PI_PASSWORD}" | chpasswd

ADD root-overlay /
RUN chown -R pi /home/pi
