
#### Run a dockerized WIKI website from a git repository of markdown files with this container which contains the Golum git-based wiki.

# wiki website powered by gollum

Gollum is a Ruby-based wiki with a Git back-end. It powers the Github wiki so you can be confident that it is robust and extremely simple to use.

All you need to do is run docker image **`devops4me/wiki`** and provide the URL of the git repository that contains the WIKI content like **https://github.com/apolloakora/devops-wiki**.


## run the wiki

The **[devops-wiki github repository](https://github.com/apolloakora/devops-wiki)** is a git-based wiki with markdown content. Let's use it alongside the **[devops4me/wiki dockerhub image](https://cloud.docker.com/repository/docker/devops4me/wiki)** to create a wiki website.

```
docker run \
    --name vm.wiki \
    --publish 4567:4567 \
    --env WIKI_CONTENT_REPO_URL=https://github.com/apolloakora/devops-wiki \
    devops4me/wiki
```

Just one command and you can browse the WIKI. Simple as pie.


## extending the wiki

If you want to extend or change the Docker image you can develop it locally using these commands.

### local docker build

    git clone https://github.com/devops4me/docker-gollum-wiki
    cd docker-gollum-wiki
    docker build --no-cache --rm --tag img.wiki .


### local docker run

```
docker run \
    --detach \
    --name vm.wiki \
    --publish 4567:4567 \
    --env WIKI_CONTENT_REPO_URL=https://github.com/apolloakora/devops-wiki \
    img.wiki
docker logs vm.wiki
```

Now visit **`http://localhost:4567/`** to browse the WiKI locally. Amend things to your liking and then push the docker image to the repository of your choice. After that you can run the website inside application docker cluster managers like Kubernetes or ECS.

You may wish (for troubleshooting) to look inside the container to check out the state of affairs.

```
docker rmi img.wiki
docker rm -vf vm.wiki
docker exec -it vm.gollum cat ../config.rb
```
