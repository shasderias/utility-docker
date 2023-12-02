#!/bin/bash

function init() {
    USERNAME=${USERNAME:-"user"}
    PUID=${PUID:-1000}
    PGID=${PGID:-1000}

    groupadd \
        --gid "$PGID" \
        "$USERNAME"

    useradd \
        --create-home \
        --home-dir "/home/$USERNAME" \
        --uid "$PUID" \
        --gid "$PGID" \
        --groups sudo \
        --shell /usr/bin/bash \
        "$USERNAME"
}

if ! id "$USERNAME" >/dev/null 2>&1; then
    init
fi

exec "/usr/local/bin/containerboot"