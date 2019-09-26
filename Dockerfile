
# --->
# ---> Extend the base ruby image for building the ruby-based
# ---> gollum wiki and WebRick web server.
# --->

FROM ruby
USER root


# --->
# ---> Setup the gollum wiki package dependencies
# --->

RUN apt-get update && apt-get --assume-yes install -qq -o=Dpkg::Use-Pty=0 \
      git             \
      libicu-dev      \
      python-pygments \
      sudo            \
      tzdata


# --->
# ---> Change the timezone for the website from the default
# ---> UTC setting to Europe/London
# --->

RUN echo "The date / time before timezone change ==] `date`" && \
    cp -vf /usr/share/zoneinfo/Europe/London /etc/localtime && \
    echo Europe/London | tee /etc/timezone && \
    echo "The date / time after timezone changes ==] `date`"


# --->
# ---> Create a sudoer(able) Gollum user and continue as them.
# --->

RUN adduser --home /var/opt/gollum --shell /bin/bash --gecos 'Gollum Git Wiki User' gollum && \
    install -d -m 755 -o gollum -g gollum /var/opt/gollum && \
    usermod -a -G sudo gollum


# --->
# ---> Copy the Gollum configuration directives file
# ---> and install the gollum and markdown gems.
# --->

COPY gollum.config.ruby /var/opt/gollum/config.rb
RUN gem install     \
    github-markdown \
    gollum          \
    kramdown

USER gollum
WORKDIR /var/opt/gollum


# --->
# ---> Configure the git installation.
# --->

RUN git config --global user.email "apollo@devopswiki.co.uk" && \
    git config --global user.name "Wiki User"


# --->
# ---> Pull in the initialize script and give run permissions
# --->

COPY gollum-wiki-start.sh .
RUN chmod u+x gollum-wiki-start.sh


# --->
# ---> docker run invokes the cert authority manager
# --->

WORKDIR /var/opt/gollum
ENTRYPOINT [ "gollum-wiki-start.sh" ]

###### WORKDIR /var/opt/gollum/wiki.content.repo
###### ENTRYPOINT [ "./../gollum-wiki-start.sh" ]

############ RUN export GIT_SSL_NO_VERIFY=1 && git clone https://www.devops-hub.com/content/devops.wiki.git git.repository
############ ENTRYPOINT ["gollum","--config","/var/opt/gollum/config.rb"]
