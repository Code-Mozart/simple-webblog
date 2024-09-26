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

### Docker and Permissions

When developing the app on the docker container you may want to run the rails generator or create some files on the container in some other way. Because the repository directory is mounted the created files will be persisted. However, because docker runs as the root user on your machine you will not be able to write to the created files (e.g. from your code editor). To fix this issue you can change the ownership of these files to your current user by running:

```sh
docker compose exec web chown -R $USER: .
```

## Tests

The app is tested using [RSpec](https://rspec.info). All endpoints are unit tested. All features have system tests.

To create the data for the examples [FactoryBot](https://github.com/thoughtbot/factory_bot_rails) and [Faker](https://github.com/faker-ruby/faker) are used.

### Running Examples/Tests

To run the examples/tests run

```sh
# To run all examples:
RAILS_ENV=test rspec

# To run a specific example (e.g. the blog model example)
RAILS_ENV=test rspec ./spec/models/blog_spec.rb:7
```

from a terminal in the container. To run them from your host machine you can prefix the command with `docker compose exec web`, e.g.:

```sh
docker compose exec web bash -c "RAILS_ENV=test rspec"
```

### Generating Specs

First open a terminal in the container and then run one of:

```sh
rails g rspec:<spec_type> <model_name>
```

For example to create request specs to the blog run:

```sh
rails g rspec:request blog
```

## Debugging

This application uses the `debug` gem (also known as `rdbg`) for debugging. A launch configuration for VS Code is included which allows you to attach the debugger to the rspec process and get a debug UI (where you can set breakpoints, etc).

### rdbg

To debug the specs in the terminal run

```sh
docker compose exec web bash -c "RAILS_ENV=test rdbg -c -- bundle exec rspec"
```

### VS Code Integration

To debug the specs in the VS Code UI first run

```sh
docker compose exec web bash scripts/start_rspec_with_debugger.sh
```

and then attach the debugger in the VS Code UI via the launch option _Attach with rdbg_. This will connect to the debug port 12345 on the container.
