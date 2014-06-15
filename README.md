# Dockerized Sixpack server, for a/b-testing

The Docker container contains sixpack and sixpack-web server environment.

## Simple Usage

If you just run sixpack with docker, you can use trusted builds registered [Docker index][di],

    docker pull ainoya/sixpack

## Deploying

* Run `docker build -t sixpack-server`
* Run `docker run -d sixpack-server`

## Running

Another example of running sixpack is:

    docker run -d -t --name sixpack-server \
                -p 5000:5000 \
                -p 49022:22 \
                -p 5001:5001 sixpack-server

You can ssh to container as root, using password:`sixpack`

    ssh root@localhost -p 49022 #The password is "sixpack".

## Contributing

Once you've made your great commits:

1. [Fork][fk] docker-sixpack
2. Create your feature branch (``git checkout -b my-new-feature``)
3. Write tests
4. Run tests with ``rake test``
5. Commit your changes (``git commit -am 'Added some feature'``)
6. Push to the branch (``git push origin my-new-feature``)
7. Create new pull request
8. That's it!

## Resources

Sixpack is a language-agnostic a/b-testing framework.

* [Introduction page](http://sixpack.seatgeek.com)
* [Sixpack repo](https://github.com/seatgeek/sixpack)


[fk]: http://help.github.com/forking/
[di]: https://index.docker.io/u/ainoya/sixpack/
