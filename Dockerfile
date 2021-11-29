# ================ PYTHON
ARG PYTHON_VERSION=3.9
FROM python:$PYTHON_VERSION

# System setup:
RUN apt-get update \
  && apt-get install -y gettext redis-tools --no-install-recommends \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Python context setup:
RUN pip install --upgrade pip pip-tools

# ================ JAVASCRIPT
ARG NODE_VERSION=14

RUN curl -sL https://deb.nodesource.com/setup_$NODE_VERSION.x | bash -
RUN apt-get install -y nodejs --no-install-recommends \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  # smoke tests
  && node --version \
  && npm --version

RUN npm install --global yarn \
  # smoke test
  && yarn --version

# ================ ENVIRONMENT
ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1
