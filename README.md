# Reddex

[![Build Status](https://semaphoreci.com/api/v1/dayweek/reddex/branches/master/badge.svg)](https://semaphoreci.com/dayweek/reddex)
[![Ebert](https://ebertapp.io/github/PrimeHammer/reddex.svg)](https://ebertapp.io/github/PrimeHammer/reddex)

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Environment
  * Set `HOST_URL` to server's DNS name (without trailing `/`, e.g. `localhost:4000`)

## Use Slack Integration

  * Set `SLACK_RTM_TOKEN` variable (See: [https://my.slack.com/services/new/bot](https://my.slack.com/services/new/bot))

## Login via Github on localhost

  * Ask @erich/@matej for github client id and secret / or use your own
  * Set `ENV GITHUB_CLIENT_ID` and `GITHUB_CLIENT_SECRET`

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
