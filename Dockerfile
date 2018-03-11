FROM elixir:1.6-slim

# Install NodeJS LTS and NPM 5
RUN apt-get update && \
    apt-get install -y curl && \
    curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
    apt-get install -y nodejs && \
    npm i -g npm@5 && \
    rm -r ~/.npm && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

COPY . .

ENV MIX_ENV=prod  
ENV SECRET_KEY_BASE="/umBxX2AmyhbDUNxzgNJH3vbzOs+5MZRc54hIMpCZMwXuiWrfMSEwvifx+AuYq5X"
# Install Rebar and Hex
RUN mix local.rebar --force && \
    mix local.hex --force && \
    mix deps.get --only prod

# Precompile Elixir/Erlang code
RUN mix compile

RUN cd /usr/src/app/assets && npm i --no-package-lock && ./node_modules/.bin/brunch build --production && cd /usr/src/app/
RUN mix phx.digest