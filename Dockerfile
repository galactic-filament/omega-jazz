FROM ruby

EXPOSE 80
ENV APP_PORT 80

# add app dir
ENV APP_DIR /srv/app
RUN mkdir $APP_DIR
WORKDIR $APP_DIR
COPY ./app $APP_DIR

# add log dir
ENV APP_LOG_DIR $APP_DIR/log
RUN mkdir $APP_LOG_DIR

# build app
RUN bundle install

CMD ["./bin/run-app"]
