FROM alpine:3.23.5

RUN apk add --no-cache bash git coreutils \
    && git config --global user.name "Git Kata"  \
    && git config --global user.email "git-kata@andrej-dyck" \
    && git config --global core.pager "" \
    && mkdir -p /git-kata

WORKDIR /git-kata

ENTRYPOINT ["/bin/bash"]
