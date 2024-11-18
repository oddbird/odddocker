ARG NODE_VERSION
ARG PYTHON_VERSION
FROM node:${NODE_VERSION} AS node_base
FROM python:${PYTHON_VERSION}

# Node and npm
COPY --from=node_base /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=node_base /usr/local/bin/node /usr/local/bin/node
RUN ln -s /usr/local/lib/node_modules/corepack/dist/corepack.js /usr/local/bin/corepack
RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm
RUN ln -s /usr/local/lib/node_modules/npm/bin/npx-cli.js /usr/local/bin/npx
RUN corepack enable
RUN node --version && npm --version && yarn --version

# System setup:
RUN apt-get update \
  && apt-get install -y gettext redis-tools --no-install-recommends \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Python context setup:
RUN pip install --no-cache-dir --upgrade pip pip-tools

# ================ ENVIRONMENT
ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1
