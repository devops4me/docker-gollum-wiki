
#### Run a WIKI website from any source git repository of markdown files and Gollum git-based wiki configuration files like templates, media and css stylesheets.

# wiki website powered by gollum

Gollum is a Ruby-based wiki with a Git back-end. It powers the Github wiki so you can be confident that it is robust and extremely simple to use.

All you need to do is docker build and run using the base docker image **`devops4me/wiki`** and provide the URL of the git repository that contains the WIKI content like **https://github.com/apolloakora/devops-wiki**.


## how to run the wiki in 3 steps

The **[devops-wiki github repository](https://github.com/apolloakora/devops-wiki)** is a git-based wiki with markdown content. Let's use it alongside the **[devops4me/wiki dockerhub image](https://cloud.docker.com/repository/docker/devops4me/wiki)** to create a wiki website.

### Step 1 | Dockerfile

The first step is to place this Dockerfile at the root of the wiki's content repository so that it can copy the wiki content into the docker machine.

```
FROM devops4me/wiki:latest

# --->
# ---> As the gollum user create wiki.dir from a clone
# ---> of the wiki content repository and set it as the
# ---> work directory.
# --->
# ---> Pass the WIKI_CONTENT_URL as a build argument.
# --->

USER gollum
ARG WIKI_CONTENT_URL
RUN git clone $WIKI_CONTENT_URL /var/opt/gollum/wiki.dir
WORKDIR /var/opt/gollum/wiki.dir
```

### Step 2 | docker build the wiki

To build **[the Dockerfile](https://github.com/apolloakora/devops-wiki/blob/master/Dockerfile)** you execute the docker build command with a **`--build-arg`** called **`WIKI_CONTENT_URL`** that specifies the git location url of the wiki's content.

```
docker build       \
    --no-cache     \
    --rm           \
    --build-arg WIKI_CONTENT_URL=https://github.com/apolloakora/devops-wiki.git \
    --tag img.wiki \
    .
```

**Beware there is a period (dot) on the final line of the build command.**

### Step 3 docker run the wiki


```
docker run \
    --detach \
    --name vm.wiki \
    --publish 4567:4567 \
    img.wiki
docker logs vm.wiki
```

Now the wiki is running in a docker machine named **`vm.wiki`** in your environment.
Access it with **`http://localhost:4567`** after a few seconds.


## local wiki development | howto

If you want to extend or change the Docker image you can develop it locally using these commands.

### local docker build

    git clone https://github.com/devops4me/docker-wiki
    cd docker-wiki
    docker build --no-cache --rm --tag img.wiki .

