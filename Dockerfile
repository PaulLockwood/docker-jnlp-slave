# Branched from https://github.com/jenkinsci/docker-jnlp-slave/

FROM jenkinsci/slave
# FROM cloudbees/jnlp-slave-with-java-build-tools

USER root

# Install Chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN  echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | tee /etc/apt/sources.list.d/google-chrome.list
RUN  apt-get update 
RUN  apt-get --yes install google-chrome-stable

#====================================
# NODE JS
# See https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions
#====================================
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash \
    && apt-get install -y nodejs 

# Install Tiny-VIM
RUN apt-get --yes install vim-tiny

# Install 7zip
RUN apt-get --yes install p7zip-full

USER jenkins

# Enable Global NPM Packages
RUN mkdir ~/.npm-global 
RUN npm config set prefix '~/.npm-global' 
# RUN touch ~/.profile
# RUN sed -i '$a export PATH=~/.npm-global/bin:$PATH' ~/.profile 
# RUN cat ~/.profile

COPY jenkins-slave /usr/local/bin/jenkins-slave

ENTRYPOINT ["jenkins-slave"]
