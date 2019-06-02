# Docker alpine ssh server
Dockerized ssh server with key-based access.

## Instructions

1. Generate all necessary keys via `make generate-keys`
2. Build the docker image and start the container via `make up`
3. Enjoy 🎉

## FAQ

### How to customize the ssh port?

The ssh port can be customized by setting the `SSH_PORT` flag while running `make up`.
To set the listening port to e.g. 22000 run `SSH_PORT=22000 make up`.