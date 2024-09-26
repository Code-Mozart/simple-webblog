# README

A simple fullstack webblog application. This is developed for an assignment from Cleaner Code.

The following features were implemented:
- Listing all blogs
- Viewing a blog in detail
- Editing a blog (supports richtext)
- Creating a new blog
- Deleting a blog
- Restricting access via HTTP Basic Authentication

## Installation

When you run the app for the first time you have to create and setup the databases. To do this run the following command:

```sh
docker compose run --entrypoint "rails db:setup" web
```

## Development

This application uses a docker-image for its development environment that mounts the local code.
To run this project you need to have [Docker](https://www.docker.com/) installed. With Docker installed
you can simply run

```sh
docker compose watch
```

to start the app. To start a terminal within the development environment run

```sh
docker compose exec web bash
```

## Tests

The app is tested using [RSpec](https://rspec.info). All endpoints are unit tested. All features have system tests.
