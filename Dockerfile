FROM centos:7

# Needed for AWS to properly handle UTF-8
ENV PYTHONIOENCODING=UTF-8

# We need python in order to install AWS
RUN yum -y update \
    && yum install -y sudo \
    && yum install -y https://centos7.iuscommunity.org/ius-release.rpm \
    && yum install -y python35u python35u-pip \
    && python3.5 -m pip install awscli requests \
    && yum install -y make

RUN curl -sSL https://s3.amazonaws.com/download.fpcomplete.com/centos/7/fpco.repo | sudo tee /etc/yum.repos.d/fpco.repo

RUN yum install -y stack

RUN useradd ag

RUN sudo -u ag stack upgrade
RUN mkdir /grade

ADD mp2-interpreter /tmp/project

RUN ls -l /tmp
RUN chown -R ag /tmp/project

RUN cd /tmp/project \
    && sudo -u ag /home/ag/.local/bin/stack setup --resolver lts-14.22 --install-ghc\
    && sudo -u ag /home/ag/.local/bin/stack --resolver lts-14.22 test \
    && sudo -u ag ls -R /home/ag/.stack \
    && sudo -u ag /home/ag/.local/bin/stack --resolver lts-14.22 path

ADD main.py
    

