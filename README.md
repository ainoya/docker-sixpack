# Dockerized Sixpack server, for a/b-testing

The Docker container contains sixpack and sixpack-web server environment.

## Deploying

* Run `docker build -t sixpack-server`
* Run `docker run -d sixpack-server`

## Running

An example of running sixpack is:

    docker run -d -t --name sixpack-server \
                -p 5000:5000 \
                -p 5001:5001 sixpack-server

## Resources

Sixpack is a language-agnostic a/b-testing framework.

* [Introduction page](http://sixpack.seatgeek.com)
* [Sixpack repo](https://github.com/seatgeek/sixpack)

