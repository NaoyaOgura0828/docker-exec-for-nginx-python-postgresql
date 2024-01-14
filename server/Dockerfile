# Set the base image
ARG BASE_IMAGE_TAG=${BASE_IMAGE_TAG}
FROM ubuntu:${BASE_IMAGE_TAG}

# Set ARG
ARG TZ=Asia/Tokyo
ARG USER_NAME=${USER_NAME}
ARG POSTGRESQL_VERSION=${POSTGRESQL_VERSION}

# Set TimeZone
RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && echo ${TZ} > /etc/timezone

# Set Locale
RUN apt-get update -y &&\
    apt-get install locales -y &&\
    locale-gen ja_JP.UTF-8
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP.UTF-8
ENV LC_ALL ja_JP.UTF-8

# Repository Update
RUN apt-get update -y &&\
    apt-get upgrade -y

# Install Packages
RUN apt-get update -y &&\
    apt-get install curl -y &&\
    apt-get install git -y &&\
    apt-get install gnupg2 -y &&\
    apt-get install software-properties-common -y &&\
    apt-get install sudo -y &&\
    apt-get install unzip -y &&\
    apt-get install vim -y &&\
    apt-get install wget -y &&\
    apt-get install zip -y

# Install nginx
RUN apt-get update -y &&\
    apt-get install nginx -y

# Setup default nginx
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./index.html /var/www/html/index.html
RUN rm /var/www/html/index.nginx-debian.html

# Install nginx
RUN apt-get update -y &&\
    apt-get install nginx -y

# Install postgresql
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo tee /etc/apt/trusted.gpg.d/postgresql.asc &&\
    echo "deb [signed-by=/etc/apt/trusted.gpg.d/postgresql.asc] http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list &&\
    apt-get update -y &&\
    apt-get install postgresql-${POSTGRESQL_VERSION} -y

# Setup default nginx
COPY ./pg_hba.conf /etc/postgresql/${POSTGRESQL_VERSION}/main/pg_hba.conf

# Add User
RUN adduser ${USER_NAME} --force-badname

# Setup to use sudo without password
RUN echo "${USER_NAME} ALL=NOPASSWD: ALL" >> /etc/sudoers &&\
    echo "${USER_NAME} ALL=(postgres) NOPASSWD: ALL"  >> /etc/sudoers

# Setup WORKDIR
WORKDIR /home/${USER_NAME}

# Change User
USER ${USER_NAME}

# Setup startup_execution.sh
COPY ./startup_execution.sh /home/${USER_NAME}/
RUN sudo chown ${USER_NAME}:${USER_NAME} ~/startup_execution.sh &&\
    chmod 700 ~/startup_execution.sh

ENTRYPOINT ~/startup_execution.sh
