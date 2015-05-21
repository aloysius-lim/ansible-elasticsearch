FROM williamyeh/ansible:ubuntu14.04-onbuild

MAINTAINER Aloysius Lim

EXPOSE 9200
CMD ["./test.sh"]
