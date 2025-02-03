FROM busybox:glibc
ENV MODULE=l0l
COPY ./bin /bin/
COPY ./inc /inc/
COPY ./lib /lib/
COPY ./src /src/
COPY ./tmp /tmp/
# COPY ./etc /etc/
# CMD ["/bin/l0l_pc_dponyatov","/lib/l0l.ini"]
# CMD ["ls","-la","/"]
# RUN opkg-install python3
# CMD ["/bin/sh"]
CMD ["/bin/l0l_pc_dponyatov","lib/l0l.ini"]
