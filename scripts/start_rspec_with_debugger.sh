# taken from https://www.reddit.com/r/rails/comments/153z1il/debug_rails_app_inside_docker_with_puma_and_vscode/

export RUBY_DEBUG_OPEN=true
export RUBY_DEBUG_PORT=12345
export RUBY_DEBUG_HOST=0.0.0.0
export RUBY_DEBUG_SKIP_BP=true
export RAILS_ENV=test

# run the rspec command with the user-provided arguments
rspec "$@"
