# Shopping List

[![Test](https://github.com/hidakatsuya/shopping_list/actions/workflows/test.yml/badge.svg?branch=main)](https://github.com/hidakatsuya/shopping_list/actions/workflows/test.yml)

A simple web application to manage shopping list.
It is built with [Rails7](https://github.com/rails/rails) and [Hotwire](https://hotwired.dev/).

## Status

Under development

## Development

```
cp .env.sample .env
```

```
docker-compose build
docker-compose run app bin/setup
docker-compose up -d app
```

## Related Projects

- [Shopping List Android](https://github.com/hidakatsuya/shopping_list-android): An Android client for Shopping List
- Shopping List CLI (comming soon): A command line interface for Shopping List
