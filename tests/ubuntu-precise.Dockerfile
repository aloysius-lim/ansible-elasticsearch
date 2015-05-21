FROM williamyeh/ansible:ubuntu12.04-onbuild

MAINTAINER Aloysius Lim

EXPOSE 9200
CMD ["tests/test.sh"]
