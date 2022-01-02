FROM python:3.9.0

# install ubuntu basics
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 python3-pip ghostscript python3-tk ffmpeg libsm6 libxext6 && rm -rf /var/lib/apt/lists/*

# install poetry + dependencies
RUN pip install --upgrade pip && pip install poetry

# set home directory and move over code
WORKDIR /tmp/loader/
COPY pyproject.toml poetry.lock /tmp/loader/

RUN poetry install --no-dev --no-ansi

COPY . .
