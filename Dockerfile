# Docker
FROM python:3.13-slim-bullseye as base
WORKDIR /app
RUN pip install --no-cache-dir poetry
COPY ./src /app
COPY ./scripts /app/scripts
COPY pyproject.toml poetry.lock README.rst /app/
RUN poetry config virtualenvs.create false
RUN poetry install
EXPOSE 5000
CMD ["uvicorn", "dockermysqlexample:app", "--host", "0.0.0.0", "--port", "8001", "--reload"]
