FROM python:3.5

RUN mkdir /app

WORKDIR /app

COPY . /app/

RUN pip install -r requirements.txt

RUN apt update && \
    apt install -y postgresql-client

ENTRYPOINT ["sh", "/app/wait-for-me.sh", "db"]

