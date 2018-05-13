FROM bitwalker/alpine-elixir-phoenix as build

ENV MIX_ENV prod

# Add the files to the image
ADD . . 

# Cache Elixir deps
RUN mix deps.get --only prod
RUN mix deps.compile

WORKDIR assets
# Cache Node deps
RUN npm i

# Compile JavaScript
RUN npm run build

WORKDIR ..
# Compile app
RUN mix compile
RUN mix phx.digest

# Generate release
RUN mix release --env=prod

FROM alpine:3.6

RUN apk add --no-cache \
    ncurses-libs \
    zlib \
    ca-certificates \
    openssl \
    bash

WORKDIR /opt/app

# Set environment variables
ENV MIX_ENV=prod

COPY --from=build /opt/app/_build/prod/rel/wetter .

# Set timezone
ENV TZ Europe/Berlin

# Set entrypoint
ENTRYPOINT ["./bin/wetter"]