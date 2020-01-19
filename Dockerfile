
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
# ---> Install gollum and other necessary ruby gems.
# --->

RUN gem install     \
    github-markdown \
    gollum          \
    kramdown


# --->
# ---> As the gollum user install the configuration file and
# ---> prepare the wiki.dir as the git content repository.
# --->

USER gollum
COPY gollum.config.ruby /var/opt/gollum/config.rb
RUN mkdir /var/opt/gollum/wiki.dir
WORKDIR /var/opt/gollum/wiki.dir


# --->
# ---> Configure the git installation.
# --->

RUN git config --global user.email "apollo@devopswiki.co.uk" && \
    git config --global user.name "Apollo Akora"


# --->
# ---> Kick off the script within /var/opt/gollum when the
# ---> docker run command is issued.
# --->

ENTRYPOINT [ "gollum", "--config=/var/opt/gollum/config.rb" ]
