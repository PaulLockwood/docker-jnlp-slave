FROM jenkinsci/slave
# FROM cloudbees/jnlp-slave-with-java-build-tools

USER root

#====================================
# NODE JS
# See https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions
#====================================
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash \
    && apt-get install -y nodejs 


USER jenkins

# Enable Global NPM Packages
RUN mkdir ~/.npm-global 
RUN npm config set prefix '~/.npm-global' 
# RUN touch ~/.profile
# RUN sed -i '$a export PATH=~/.npm-global/bin:$PATH' ~/.profile 
# RUN cat ~/.profile

COPY jenkins-slave /usr/local/bin/jenkins-slave

ENTRYPOINT ["jenkins-slave"]
