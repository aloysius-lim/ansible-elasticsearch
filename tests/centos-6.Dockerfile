FROM williamyeh/ansible:centos6-onbuild

MAINTAINER Aloysius Lim

EXPOSE 9200
CMD ["tests/test.sh"]
