
run-interactive: build
	docker run -it --rm --privileged --name crc-docker --tmpfs /tmp --tmpfs /run --device=/dev/kvm --device=/dev/net/tun -v /sys/fs/cgroup:/sys/fs/cgroup:rw --cap-add=NET_ADMIN --cap-add=SYS_ADMIN --entrypoint bash crc-docker

run: build
	docker run --rm --privileged --name crc-docker --tmpfs /tmp --tmpfs /run --device=/dev/kvm --device=/dev/kvm --device=/dev/net/tun -v /sys/fs/cgroup:/sys/fs/cgroup:rw --cap-add=NET_ADMIN --cap-add=SYS_ADMIN crc-docker

build:
	docker build --tag crc-docker .
