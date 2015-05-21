FROM williamyeh/ansible:debian7-onbuild

MAINTAINER Aloysius Lim

RUN apt-get update && apt-get install -y curl
EXPOSE 9200
CMD ["tests/test.sh"]
