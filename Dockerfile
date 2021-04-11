FROM ubuntu

ARG VMUSER=pilillo
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install --yes qemu-kvm libvirt-daemon libvirt-daemon-system libvirt-dev network-manager sudo

COPY crc-linux-amd64.tar.xz .

RUN tar -xf crc-linux-amd64.tar.xz \
    && rm crc-linux-amd64.tar.xz

RUN adduser $VMUSER \
    && usermod -aG sudo $VMUSER \
    && echo "$VMUSER  ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/${VMUSER}

# Add Tini
#ENV TINI_VERSION v0.19.0
#ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
#RUN chmod +x /tini

#ENTRYPOINT ["/tini", "--"]

USER $VMUSER

COPY entrypoint.sh .

#CMD ["./entrypoint.sh"]
ENTRYPOINT ["./entrypoint.sh"]
