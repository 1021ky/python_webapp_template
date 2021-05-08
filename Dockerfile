# transform poetry.lock to requirements.lock
FROM python:3.9-buster as transformer

WORKDIR /tmp
RUN pip install --upgrade pip && pip install poetry
COPY pyproject.toml poetry.lock ./
RUN poetry export -f requirements.txt -o requirements.lock

# build dependencies
FROM python:3.9-buster as builder

WORKDIR /tmp

COPY --from=transformer /tmp/requirements.lock /tmp/
RUN pip install -r requirements.lock

# build runtime container
FROM python:3.9-slim-buster as runner

COPY --from=builder /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages
COPY --from=builder /usr/local/bin/uwsgi /usr/local/bin/uwsgi

RUN apt update \
    && apt install -y libpq5 libxml2 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/www/package && \
    mkdir -p /var/log/app_logs && \
    chown -R www-data /var/log/app_logs && \
    chown -R www-data /opt/www

COPY uwsgi.ini /opt/www
COPY package /opt/www/package

USER www-data
WORKDIR /opt/www
EXPOSE 8000
CMD ["uwsgi", "/opt/www/uwsgi.ini"]