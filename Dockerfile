FROM python:3.10-buster as py-build

# [Optional] Uncomment this section to install additional OS packages.
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
     && apt-get -y install --no-install-recommends netcat util-linux \
        vim bash-completion yamllint postgresql-client python3-dev \
        libpq-dev

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

COPY . /app
WORKDIR /app
RUN uv sync

FROM node:14.20.0 as js-build

COPY . /app
WORKDIR /app
RUN npm install && npm run production

FROM python:3.10-slim-buster

RUN apt-get update && apt-get -y install libpq-dev

EXPOSE 8000
COPY --from=py-build /app /app
COPY --from=js-build /app/static /app/static
WORKDIR /app
CMD /app/.render/run.sh
