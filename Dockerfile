FROM ruby

ADD ./app /srv/app
WORKDIR /srv/app

RUN bundle install

CMD ["bash"]
