FROM williamyeh/ansible:centos6-onbuild

MAINTAINER Aloysius Lim

RUN yum install -y which
EXPOSE 9200
CMD ["tests/test.sh"]
