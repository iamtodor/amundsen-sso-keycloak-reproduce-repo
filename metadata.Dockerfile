FROM amundsendev/amundsen-metadata-oidc:latest

COPY keycloak-oidc.json keycloak-oidc.json

# the next command needs to avoid the following issue
# https://github.com/amundsen-io/amundsen/issues/1157
# https://github.com/amundsen-io/amundsen/pull/1169
RUN pip install --no-cache-dir --upgrade SQLAlchemy==1.3.23

ENV FLASK_OIDC_SECRET_KEY '2c789fcb-0b6a-4c56-b571-3cb0cc342b0a'
ENV FLASK_OIDC_LOG_LEVEL DEBUG

ENV OIDC_CLIENT_SECRETS 'keycloak-oidc.json'