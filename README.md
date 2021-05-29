# HOWTO

To reproduce the issue:
1. Run `docker run --hostname host -p 8080:8080 -e KEYCLOAK_USER=admin -e KEYCLOAK_PASSWORD=admin quay.io/keycloak/keycloak:13.0.1`
2. login to `http://localhost:8080/auth/admin` with admin/admin
3. Setup authentication as it described here https://nirav-langaliya.medium.com/setup-oidc-authentication-with-lyft-amundsen-via-okta-eb0b89d724d3
with keycloak integration:
   - client id: amundsen-frontend
   - client protocol: openid-connect
   - access type: confidential
   - valid Redirect URIs : http://localhost:5000/*
   - Base URL : http://localhost:5000/
4. Create new user
5. Copy your newly generated secret to:
   - `cloak/keycloak.json/client_secret`
   - `frontend.Dockerfile/FLASK_OIDC_SECRET_KEY`
6. run `docker-compose -f docker-compose.yml up`
7. open `http://localhost:5000/`
8. login with previously created user in step #4
9. Observe the following logs in frontend container:
```log
2021-05-29T09:52:04+0000.502 [ERROR] app.log_exception:1761 (1:Thread-6) - Exception on /oidc_callback [GET]
Traceback (most recent call last):
  File "/usr/local/lib/python3.7/site-packages/flask/app.py", line 2292, in wsgi_app
    response = self.full_dispatch_request()
  File "/usr/local/lib/python3.7/site-packages/flask/app.py", line 1815, in full_dispatch_request
    rv = self.handle_user_exception(e)
  File "/usr/local/lib/python3.7/site-packages/flask_restful/__init__.py", line 272, in error_router
    return original_handler(e)
  File "/usr/local/lib/python3.7/site-packages/flask/app.py", line 1718, in handle_user_exception
    reraise(exc_type, exc_value, tb)
  File "/usr/local/lib/python3.7/site-packages/flask/_compat.py", line 35, in reraise
    raise value
  File "/usr/local/lib/python3.7/site-packages/flask/app.py", line 1813, in full_dispatch_request
    rv = self.dispatch_request()
  File "/usr/local/lib/python3.7/site-packages/flask/app.py", line 1799, in dispatch_request
    return self.view_functions[rule.endpoint](**req.view_args)
  File "/usr/local/lib/python3.7/site-packages/flask_oidc/__init__.py", line 657, in _oidc_callback
    plainreturn, data = self._process_callback('destination')
  File "/usr/local/lib/python3.7/site-packages/flask_oidc/__init__.py", line 689, in _process_callback
    credentials = flow.step2_exchange(code)
  File "/usr/local/lib/python3.7/site-packages/oauth2client/_helpers.py", line 133, in positional_wrapper
    return wrapped(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/oauth2client/client.py", line 2054, in step2_exchange
    http, self.token_uri, method='POST', body=body, headers=headers)
  File "/usr/local/lib/python3.7/site-packages/oauth2client/transport.py", line 282, in request
    connection_type=connection_type)
  File "/usr/local/lib/python3.7/site-packages/httplib2/__init__.py", line 1709, in request
    conn, authority, uri, request_uri, method, body, headers, redirections, cachekey,
  File "/usr/local/lib/python3.7/site-packages/httplib2/__init__.py", line 1424, in _request
    (response, content) = self._conn_request(conn, request_uri, method, body, headers)
  File "/usr/local/lib/python3.7/site-packages/httplib2/__init__.py", line 1346, in _conn_request
    conn.connect()
  File "/usr/local/lib/python3.7/site-packages/httplib2/__init__.py", line 1046, in connect
    raise socket_err
  File "/usr/local/lib/python3.7/site-packages/httplib2/__init__.py", line 1029, in connect
    self.sock.connect((self.host, self.port) + sa[2:])
OSError: [Errno 99] Cannot assign requested address
```
