FROM python:3.7.2

# install ubuntu basics
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 python3-pip && rm -rf /var/lib/apt/lists/*

# install poetry + dependencies
RUN pip install poetry
WORKDIR /tmp/loader/

# set home directory and move over code
COPY . .
RUN poetry install --no-root --no-dev
