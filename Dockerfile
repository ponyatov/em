FROM alpine
# FROM busybox:glibc
# FROM frolvlad/alpine-glibc

COPY ./bin              /home/bin/
COPY ./etc              /etc/
COPY ./lib              /home/lib/
COPY ./tmp/.gitignore   /home/tmp/

COPY ./hw               /home/hw/
COPY ./cpu              /home/cpu/
COPY ./arch             /home/arch/
COPY ./os               /home/os/
COPY ./inc              /home/inc/
COPY ./src              /home/src/
COPY ./tmp/*.?pp        /home/tmp/

COPY ./CMake*           /home/
COPY ./cmake            /home/cmake/
COPY ./Makefile         /home/
COPY ./mk               /home/mk/

COPY ./doc/*.md         /home/doc/
COPY ./doc/*.xml        /home/doc/
COPY ./doc/logo.png     /home/doc/

USER    nobody
WORKDIR /home

CMD ["/bin/sh"]
