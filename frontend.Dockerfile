FROM amundsendev/amundsen-frontend-oidc:latest

COPY /cloak /cloak

ENV FLASK_APP_MODULE_NAME flaskoidc
ENV FLASK_APP_CLASS_NAME FlaskOIDC

##setup FRONTEND_SVC_CONFIG_MODULE_CLASS to invoke OidcConfig module ./amundsen_application/wsgi.py 

ENV FRONTEND_SVC_CONFIG_MODULE_CLASS 'amundsen_application.oidc_config.OidcConfig'

##setup flaskoidc for ./amundsen_application/__init__.py

ENV APP_WRAPPER flaskoidc
ENV APP_WRAPPER_CLASS FlaskOIDC

ENV SQLALCHEMY_DATABASE_URI 'sqlite:///sessions.db'

ENV SESSION_TYPE 'sqlalchemy'

ENV FLASK_OIDC_SECRET_KEY 'fe4843b4-5abe-4122-83d4-309235b03625'

ENV FLASK_OIDC_WHITELISTED_ENDPOINTS "status,healthcheck,health"
ENV FLASK_OIDC_LOG_DATE_FORMAT '%Y-%m-%dT%H:%M:%S%z'
ENV FLASK_OIDC_LOG_LEVEL 'INFO'

ENV OIDC_CLIENT_SECRETS '/cloak/keycloak.json'