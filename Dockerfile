# Container image that runs your code
FROM python:3.8

# ENV PATH "$PATH:/usr/local/lib/python3.7/site-packages"
# Copies your code file from your action repository to the filesystem path `/` of the container

WORKDIR  /
# install nbdime
RUN pip install --upgrade nbdime==2.0.0

# install git
RUN apt-get update && apt-get install -y git


# install node and npm
RUN apt-get update && apt-get -y install nodejs npm
RUN npm install npm@latest -g

# Code file to execute when the docker container starts up (`entrypoint.sh`)asd
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

# install node deps
COPY package.json /
RUN npm install

COPY comment.js /
ENTRYPOINT ["/entrypoint.sh"]
