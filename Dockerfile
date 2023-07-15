FROM ruby:2.7.5

WORKDIR /app

RUN apt-get update -qq && apt-get install -y nodejs

COPY Gemfile* ./
RUN gem install bundler && bundle install --jobs 4 --retry 3

COPY . .

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
