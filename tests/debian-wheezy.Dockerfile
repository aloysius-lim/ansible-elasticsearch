FROM williamyeh/ansible:debian7-onbuild

MAINTAINER Aloysius Lim

EXPOSE 9200
CMD ["tests/test.sh"]
