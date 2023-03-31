FROM rust:alpine as builder

# Compile versatiles
WORKDIR /usr/src/versatiles
RUN apk add sqlite-dev curl gzip musl-dev git curl
RUN git clone https://github.com/versatiles-org/versatiles.git /usr/src/versatiles
RUN git switch tags/v0.2.14 --detach
RUN rustup default stable
RUN cargo install versatiles 

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


FROM scratch
WORKDIR /data/

# Copy files from builder
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /etc/group /etc/group
COPY --chown=appuser:appuser --from=builder /usr/local/cargo/bin/versatiles /usr/local/bin/versatiles

USER appuser
EXPOSE 8080

CMD ["/usr/local/bin/versatiles", "serve", "-i", "0.0.0.0", "-p", "8080", "-s", "/data/static", "/data/tiles/osm.versatiles"]