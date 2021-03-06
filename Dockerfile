# Based on https://docs.docker.com/samples/rails/
FROM ruby:3.0.3

RUN apt-get update -qq && apt-get install -y libvips postgresql-client

ENV APP_HOME=/rails7_demo
ENV RAILS_ENV=development

WORKDIR /rails7_demo
COPY Gemfile /rails7_demo/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
