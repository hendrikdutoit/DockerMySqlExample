FROM python:3.10-slim
WORKDIR /app
RUN pip install --no-cache-dir poetry
COPY ./src /app
COPY pyproject.toml poetry.lock README.rst /app/
RUN poetry config virtualenvs.create false
RUN poetry install
EXPOSE 8001
CMD ["uvicorn", "dockermysqlexample:app", "--host", "0.0.0.0", "--port", "8001", "--reload"]
