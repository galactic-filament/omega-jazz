FROM ruby

EXPOSE 80

COPY ./app /srv/app
WORKDIR /srv/app

RUN bundle install

CMD ["./bin/run-app"]
