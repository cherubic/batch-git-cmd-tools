FROM alpine:3.16.0

RUN apk fix && \
    apk --no-cache --update add git git-lfs less openssh wget grep bash && \
    git lfs install

RUN wget https://github.com/mikefarah/yq/releases/download/v4.25.3/yq_linux_amd64 -O /usr/bin/yq &&\
    chmod +x /usr/bin/yq

ENTRYPOINT [ "/batch-git-command.sh" ]
CMD ["--help"]