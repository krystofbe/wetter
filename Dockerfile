FROM bitwalker/alpine-elixir-phoenix

RUN apk add python2 \
    tzdata \
    postgresql-client \
    && rm -rf /var/cache/apk/*

ENV TZ Europe/Berlin


WORKDIR /app
COPY . .
