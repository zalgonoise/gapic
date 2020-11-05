FROM alpine:edge as builder

# Define branch to fetch from 

ARG BRANCH=dev

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

# Fetch repo

RUN git clone -b $BRANCH https://github.com/zalgonoise/gapic 

#RUN ["git", "clone", "-b", "feature/docker", "https://github.com/zalgonoise/gapic"]

# Move into repo directory (to properly log this build)

WORKDIR /gapic

# Build gapic

RUN ["zsh", "/gapic/gapic.sh"]

# Kick-off from an alpine base image with zsh

FROM zalgonoise/docker-baseimage-alpine:latest

LABEL maintainer="Zalgo Noise <zalgo.noise@gmail.com>"
LABEL version="0.6-beta"
LABEL git_repo="https://github.com/zalgonoise/gapic"

# Get source files

COPY --from=builder /gapic/src /src

# Add needed dependencies
# jq to parse JSON
# fzf (fuzzy finder) is the program of choice for menus

RUN apk add \
    --no-cache \
    --update \
    jq \
    fzf

# Prepare gapic to execute on container runtime

RUN chown -R app:app /src

CMD ["/src/bin/gapic_exec.sh"]