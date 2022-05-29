FROM ruby:alpine3.16

ENV PORT=4567

RUN mkdir /app
COPY . /app

WORKDIR /app

RUN apk -U add build-base

RUN cd /app && \
  bundle install -j4

CMD ruby ./app.rb -p $PORT
