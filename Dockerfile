# ================ PYTHON
ARG PYTHON_VERSION
FROM python:$PYTHON_VERSION

# System setup:
RUN apt-get update \
  && apt-get install -y gettext redis-tools --no-install-recommends \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Python context setup:
RUN pip install --upgrade pip pip-tools

# ================ NODE
# https://github.com/nodesource/distributions/blob/master/README.md#installation-instructions
ARG NODE_VERSION
RUN curl -fsSL https://deb.nodesource.com/setup_$NODE_VERSION.x | bash -
RUN apt-get install -y nodejs --no-install-recommends \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  # smoke tests
  && node --version

# https://classic.yarnpkg.com/en/docs/install
RUN npm install --global yarn npm@latest \
  # smoke test
  && yarn --version
  && npm --version

# ================ ENVIRONMENT
ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1
