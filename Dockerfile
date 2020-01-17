
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


# --->
# ---> Pull in the initialize script and give run permissions
# --->

COPY gollum-wiki-start.sh /var/opt/gollum
RUN chmod a+x /var/opt/gollum/gollum-wiki-start.sh


# --->
# ---> Now switch to the lesser permissioned gollum user
# --->

USER gollum
WORKDIR /var/opt/gollum


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
