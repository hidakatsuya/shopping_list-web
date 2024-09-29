# Shopping List

[![Test](https://github.com/hidakatsuya/shopping_list/actions/workflows/test.yml/badge.svg?branch=main)](https://github.com/hidakatsuya/shopping_list/actions/workflows/test.yml)

A simple web application to manage shopping list.
It is built with [Rails7](https://github.com/rails/rails) and [Hotwire](https://hotwired.dev/) and [Tailwind CSS](https://tailwindcss.com/).

- Sign up and sign in with Google account
- Managing items on shopping list
- Updating the completion status of items
- Dark mode support
- Multiple language support
- API for adding items: `POST /items`

<div>
  <img src="doc/light-items.png" width="45%">
  <img src="doc/dark-items.png" width="45%">
</div>

<div>
  <img src="doc/light-sign-in.png" width="23%">
  <img src="doc/light-settings.png" width="23%">
  <img src="doc/dark-sign-in.png" width="23%">
  <img src="doc/dark-settings.png" width="23%">
</div>

## Related Products

- [Shopping List Android](https://github.com/hidakatsuya/shopping_list-android): An Android client for Shopping List
- [Shopping List CLI](https://github.com/hidakatsuya/shopping_list-cli): A command line interface for Shopping List

## Built With

- Ruby 3.3
- Rails 7.2
- Turbo (turbo-rails)
- Propshaft
- Tailwind CSS (tailwindcss-rails)
- SQLite

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

- Google OAuth Client
- Ruby or Docker

### Installing

Copy .env.sample to create .env, and set the client ID and secret key for Google OAuth client.

```
cp .env.sample .env
```

Then, execute the followings to launch the application.

```
./bin/setup
./bin/dev
```

Alternatively, you can launch the application in a Docker container.

```
docker compose build
docker compose run app bin/setup
docker compose up -d
```

## Running the tests

First, refer to the above and launch the application in a Docker container.

Runnning unit tests:
```
docker compose exec app bin/rails test
```

Running system tests:
```
docker compose exec app bin/rails test:system
```

Running all tests:
```
docker compose exec app bin/rails test:all
```

## Deploying to production using Kamal

Copy .env.sample to create .env.production, and set the settings.

```
cp .env.sample .env.production
```

> [!Note]
> You may need to add SECRET_KEY_BASE and KAMAL_REGISTRY_PASSWORD environment variables.

Configure Kamal with reference to [the official documentation](https://kamal-deploy.org/docs/installation).

Run the `bin/kamal` to deploy. `bin/kamal` loads `.env.production` file present in the application root.

> [!CAUTION]
> Do not run `kamal` directly. Kamal loads `.env` file present in the application root.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
