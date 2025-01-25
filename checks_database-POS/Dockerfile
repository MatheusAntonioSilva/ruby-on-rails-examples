FROM ruby:2.7.2

EXPOSE 9292
EXPOSE 4567

RUN mkdir /app
WORKDIR /app
COPY . /app

RUN gem install bundler && bundle install
RUN gem cleanup minitest

CMD ["/bin/bash"]
