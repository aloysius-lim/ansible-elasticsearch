FROM williamyeh/ansible:debian8-onbuild

MAINTAINER Aloysius Lim

EXPOSE 9200
CMD ["./test.sh"]
