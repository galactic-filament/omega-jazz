FROM ruby

EXPOSE 80

ADD ./app /srv/app
WORKDIR /srv/app

RUN bundle install

CMD ["rackup", "-p", "4567", "--host", "0.0.0.0"]
