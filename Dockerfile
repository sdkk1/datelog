FROM ruby:2.5.7

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

RUN mkdir /date-match
WORKDIR /date-match

COPY Gemfile /date-match/Gemfile
COPY Gemfile.lock /date-match/Gemfile.lock

ENV BUNDLER_VERSION 2.1.4
RUN gem install bundler
RUN bundle install
COPY . /date-match

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
