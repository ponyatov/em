FROM alpine
# FROM busybox:glibc
# FROM frolvlad/alpine-glibc

USER    nobody
WORKDIR /home

COPY ./bin              /home/bin/
COPY ./doc/*.md         /home/doc/
COPY ./doc/*.xml        /home/doc/
COPY ./doc/logo.png     /home/doc/
COPY ./etc              /etc/
COPY ./inc              /home/inc/
COPY ./lib              /home/lib/
COPY ./src              /home/src/
COPY ./tmp/.gitignore   /home/tmp/
COPY ./tmp/*.?pp        /home/tmp/
COPY ./CMake*           /home/
COPY ./cmake            /home/cmake/
COPY ./Makefile         /home/
COPY ./mk               /home/mk/
COPY ./hw               /home/hw/
COPY ./cpu              /home/cpu/
COPY ./arch             /home/arch/
COPY ./os               /home/os/

CMD ["/bin/sh"]
