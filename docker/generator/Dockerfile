FROM debian AS builder


WORKDIR /opt
RUN apt-get update; \
    apt-get install -y build-essential \
                       libboost-dev \
                       libboost-filesystem-dev \
                       libboost-iostreams-dev \
                       libboost-program-options-dev \
                       libboost-system-dev \
                       liblua5.1-0-dev \
                       libprotobuf-dev \
                       libshp-dev \
                       libsqlite3-dev \
                       protobuf-compiler \
                       rapidjson-dev \
                       git \
                       wget \
                       unzip \
                       tmux \
                       htop \
                       aria2 \
                       osmium-tool \
                       sysstat \
                       brotli \
                       gdal-bin \
                       cmake \
                       ifstat \
                       curl
RUN git clone -q --branch z-order-float https://github.com/geofabrik/tilemaker.git tilemaker; \
    cd tilemaker; make -s; cd ~

RUN git clone -q -b fix_admin_json_syntax https://github.com/noxiii/shortbread-tilemaker shortbread-tilemaker; \
    cd shortbread-tilemaker; ./get-shapefiles.sh


# Create appuser
ENV USER=appuser
ENV UID=1000
RUN adduser \ 
--disabled-password \ 
--gecos "" \ 
--home "/nonexistent" \ 
--shell "/sbin/nologin" \ 
--no-create-home \ 
--uid "${UID}" \ 
"${USER}"
RUN mkdir /data; \
    chown appuser /data; \
    chmod 775 /data

FROM debian
WORKDIR /data/
RUN apt-get update; \
    apt-get install -y \
        libboost-dev \
        libboost-filesystem-dev \
        libboost-iostreams-dev \
        libboost-program-options-dev \
        libboost-system-dev \
        liblua5.1-0-dev \
        libprotobuf-dev \
        libshp-dev \
        libsqlite3-dev \
        osmium-tool \
        curl; \
    apt-get clean

# Copy files from builder
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /etc/group /etc/group
COPY --chown=appuser:appuser --from=builder /data /data
COPY --chown=appuser:appuser --from=builder /opt/tilemaker/tilemaker /usr/local/bin/tilemaker
COPY --chown=appuser:appuser --from=builder /opt/shortbread-tilemaker /opt/shortbread-tilemaker
COPY --chown=appuser:appuser --chmod=750 ./convert.sh /usr/local/bin/convert.sh

USER appuser

CMD ["/usr/local/bin/convert.sh"]

