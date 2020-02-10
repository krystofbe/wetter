##
# Assets

FROM node:10-slim AS assets

RUN set -xe; \
  apt-get update; \
  apt-get install -y --no-install-recommends \
  inotify-tools \
  git \
  ; \
  rm -rf /var/lib/apt/lists/*

WORKDIR /app/assets

RUN mkdir -p /app/priv/static

COPY ./assets /app/assets

ARG ENV=prod
ARG SENTRY_DSN
ENV NODE_ENV dev

RUN yarn install
RUN if [ "$ENV" = "prod" ]; then yarn run deploy; fi

##
# App

FROM elixir:1.8-slim AS app

RUN set -xe; \
  apt-get update; \
  apt-get install -y --no-install-recommends \
  inotify-tools \
  git \
  make \
  gcc \
  libssl1.1 \
  ca-certificates \
  ; \
  rm -rf /var/lib/apt/lists/*

RUN mix local.rebar --force && mix local.hex --force

WORKDIR /app
RUN mkdir -p priv/static

COPY --from=assets /app/priv/static/ ./priv/static/

ARG ENV=prod
ARG DEFAULT_URL_HOST
ARG HTTP_SCHEME
ARG HTTP_PORT
ENV MIX_ENV $ENV

# Install and compile dependencies
COPY mix.exs mix.lock ./
RUN mix deps.get
RUN mix deps.compile

# Install and compile the rest of the app
COPY . ./
RUN if [ "$ENV" = "prod" ]; then mix do phx.digest, distillery.release --executable; fi

##
# Run

FROM debian:stretch-slim

ENV DEBIAN_FRONTEND noninteractive
RUN set -xe; \
  apt-get -qq update; \
  apt-get install -y --no-install-recommends \
  xmlstarlet \
  poppler-utils \
  unzip \
  curl \
  locales \
  openssl \
  ; \
  rm -rf /var/lib/apt/lists/*

# Set LOCALE to UTF8
RUN echo "de_DE.UTF-8 UTF-8" > /etc/locale.gen && \
  locale-gen de_DE.UTF-8 && \
  dpkg-reconfigure locales && \
  /usr/sbin/update-locale LANG=de_DE.UTF-8


ENV LC_ALL de_DE.UTF-8

ARG PORT
EXPOSE ${PORT}

WORKDIR /app

COPY --from=app /app/_build/prod/rel/wetter .

ENTRYPOINT ["./bin/wetter"]
CMD ["foreground"]
