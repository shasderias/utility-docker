FROM tailscale/tailscale:latest AS tailscale-build

FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get install --assume-yes --no-install-recommends \
    ca-certificates \
    curl \
    tmux \
    sudo \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN echo "%sudo ALL=(ALL:ALL) NOPASSWD: ALL" >>/etc/sudoers

COPY --from=tailscale-build /usr/local/bin/tailscale /usr/local/bin/
COPY --from=tailscale-build /usr/local/bin/tailscaled /usr/local/bin/
COPY --from=tailscale-build /usr/local/bin/containerboot /usr/local/bin/

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
