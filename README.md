# LocIm

# Users
  * GET /users/:id        
  * GET /users/:id/follow
  * GET /users/:id/unfollow

# Location
  * GET /location/
    - latitude, type: float, required: true
    - longitude, type: float, required: true
    - radius, type: integer, required: true
    - category, type: string, required: false

# Feed
  * GET /feed(/:page_number)

# Posts
  * GET /posts/:id
  * POST /posts/
    - image, type: file, required: true
    - latitude, type: float, required: true
    - longitude, type: float, required: true
    - category, type: string, required: true
    - reaction, type: boolean, required: true


To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: http://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
