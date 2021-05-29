FROM amundsendev/amundsen-metadata-oidc:latest

COPY /cloak /cloak

# the next command needs to avoid the following issue
# https://github.com/amundsen-io/amundsen/issues/1157
# https://github.com/amundsen-io/amundsen/pull/1169
RUN pip install --no-cache-dir --upgrade SQLAlchemy==1.3.23

ENV FLASK_OIDC_SECRET_KEY 'fe4843b4-5abe-4122-83d4-309235b03625'
ENV FLASK_OIDC_LOG_LEVEL DEBUG

ENV OIDC_CLIENT_SECRETS '/cloak/keycloak.json'