
# Wiki Website Powered by Gollum

Gollum is a Ruby-based wiki  with a Git back-end. It powers Github and you can bolt on the web server of your choosing to override the default Ruby WeBrick server.

DockerHub will use the Dockerfile to build the base gollum wiki image that can then be extended by adding git-based wiki content.


## docker run | locally

Let's fire up the WIKI locally and check it over before deploying the docker container into a cluster manager like Kubernetes or ECS.

```
cd       # to this directory
docker build --rm --tag img.wiki .
docker run --name vm.goolum --publish 4567:4567 img.wiki
```

Now you can visit **http://localhost:4567/** and the Wiki home page should show.

## Troubleshooting the Container

At times you may want to look inside the container to discover the state of affairs.

```
docker exec -it vm.gollum cat ../config.rb
```

