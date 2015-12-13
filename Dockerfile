FROM ruby

EXPOSE 80

RUN apt-get update -q \
  && apt-get install -yq netcat

COPY ./app /srv/app
WORKDIR /srv/app

RUN bundle install

CMD ["rackup", "-p", "80", "--host", "0.0.0.0"]
