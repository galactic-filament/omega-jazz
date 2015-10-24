FROM ruby

ADD ./app /srv/app
WORKDIR /srv/app

CMD ["bash"]
