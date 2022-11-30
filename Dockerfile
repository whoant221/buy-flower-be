FROM ruby:2.6.8-alpine3.13
RUN apk add --update \
    build-base  \
    ruby-dev \
    postgresql-dev \
    gcompat \
    tzdata

ENV TZ=Asia/bangkok
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ARG RAILS_ENV=production
ENV RAILS_ENV $RAILS_ENV
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

ENV APP_PATH /opt/buy-flower
RUN mkdir $APP_PATH
WORKDIR $APP_PATH

COPY Gemfile $APP_PATH/Gemfile
COPY Gemfile.lock $APP_PATH/Gemfile.lock
RUN gem install bundler -v '~> 1.17.3'
RUN bundle install --retry 2 --without=development test

ADD . $APP_PATH
EXPOSE 3000
RUN chmod +x /opt/buy-flower/docker/rails.sh
RUN chmod +x /opt/buy-flower/docker/sidekiq.sh
CMD ["/opt/buy-flower/docker/rails.sh"]