FROM ruby:2.7.2-buster

ARG APP_DIR=/app
ARG USER_ID=1000
ARG GROUP_ID=1000

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  \
  && curl -sL https://deb.nodesource.com/setup_12.x | bash - \
  \
  && apt-get update -qq \
  && apt-get install -y \
  nodejs \
  postgresql-client \
  yarn \
  \
  && rm -rf /var/lib/apt/lists/* \
  \
  && groupadd --gid $GROUP_ID user \
  && useradd --no-log-init --uid $USER_ID --gid $GROUP_ID user --create-home \
  \
  && mkdir -p $APP_DIR

COPY entrypoint.sh /usr/bin/
COPY --chown=$USER_ID:$GROUP_ID Gemfile* $APP_DIR/

RUN chmod +x /usr/bin/entrypoint.sh \
  && chown -R $USER_ID:$GROUP_ID $APP_DIR

# switching to app user
USER $USER_ID:$GROUP_ID
WORKDIR $APP_DIR

COPY --chown=$USER_ID:$GROUP_ID . $APP_DIR

EXPOSE 3000

ENTRYPOINT ["entrypoint.sh"]

CMD bundle exec rails server -b 0.0.0.0 -p ${PORT:-3000}
