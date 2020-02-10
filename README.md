# Wetter

To start your Phoenix server:

- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.create && mix ecto.migrate`
- Install Node.js dependencies with `cd assets && npm install`
- Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## (Setup)

install docker-py: `pip install docker`

### Server setup

    Refer to `git/krystofbe-infrastructure`

## AWS ECR

Retrieve the login command to use to authenticate your Docker client to your registry.
Use the AWS CLI:

\$(aws ecr get-login --no-include-email --region eu-central-1)

Note: If you receive an "Unknown options: --no-include-email" error when using the AWS CLI, ensure that you have the latest version installed. Learn more
Build your Docker image using the following command. For information on building a Docker file from scratch see the instructions here
. You can skip this step if your image is already built:

docker build -t wetter .

After the build completes, tag your image so you can push the image to this repository:

docker tag wetter:latest 713759161179.dkr.ecr.eu-central-1.amazonaws.com/wetter:latest

Run the following command to push this image to your newly created AWS repository:

docker push 713759161179.dkr.ecr.eu-central-1.amazonaws.com/wetter:latest

## Learn more

- Official website: http://www.phoenixframework.org/
- Guides: http://phoenixframework.org/docs/overview
- Docs: https://hexdocs.pm/phoenix
- Mailing list: http://groups.google.com/group/phoenix-talk
- Source: https://github.com/phoenixframework/phoenix
