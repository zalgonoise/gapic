FROM alpine:edge as builder

# Add needed tools to build gapic
# zsh will follow gapic.sh through the building process
# git gets the github repo
# jq parses JSON (schema)
# coreutils provides time in micro-seconds (due to busybox)
# curl to fetch the API schema

RUN apk add \
    --no-cache \
    --update \
    zsh \
    git \
    jq \
    coreutils \
    curl

# fetch repo

RUN ["git", "clone", "-b", "feature/docker", "https://github.com/zalgonoise/gapic"]

# move into repo directory (to properly log this build)

WORKDIR /gapic

# build gapic

RUN ["zsh", "/gapic/gapic.sh"]


FROM alpine:edge

LABEL maintainer="Zalgo Noise <zalgo.noise@gmail.com>"
LABEL version="0.6-beta"
LABEL git_repo="https://github.com/zalgonoise/gapic"

# get source files

COPY --from=builder /gapic/src /src

# add needed dependencies
# zsh as the main interpreter
# jq to parse JSON
# coreutils provides time in micro-seconds (due to busybox)
# curl performs HTTP requests
# fzf (fuzzy finder) is the program of choice for menus

RUN apk add \
    --no-cache \
    --update \
    zsh \
    jq \
    coreutils \
    curl \
    fzf

# execute gapic on container runtime

CMD ["/src/bin/gapic_exec.sh"]