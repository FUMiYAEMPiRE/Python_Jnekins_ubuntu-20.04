FROM ubuntu

LABEL FUMiYA EMPiRE

USER root
RUN apt-get update && apt-get install -y \
    sudo \
    wget \
    systemctl \
    python3 \
    vim \
    curl

RUN apt-get install -my wget gnupg
RUN sudo apt install -y openjdk-8-jdk
RUN wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
RUN sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
RUN sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
RUN sudo wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
RUN sudo apt update -y


RUN sudo apt install -y \
    python3-pip \
    jenkins \
    language-pack-ja \
    google-chrome-stable
    

RUN sudo update-locale LANG=ja_JP.UTF-8
ARG project_dir=/var
ADD requirements.txt $project_dir
WORKDIR $project_dir
RUN pip3 install -r requirements.txt
VOLUME /var