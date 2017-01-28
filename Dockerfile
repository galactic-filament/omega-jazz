FROM ruby

EXPOSE 80

COPY ./app /srv/app
WORKDIR /srv/app

# RUN bundle install

CMD ["rackup", "-p", "80", "--host", "0.0.0.0"]
