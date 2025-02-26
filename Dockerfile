FROM python:3.12-slim

ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Install Poetry
RUN pip install --no-cache-dir poetry

# Copy everything needed for the package
COPY pyproject.toml poetry.lock ./
COPY protottyde/ ./protottyde/
COPY test-server/ ./test-server/

# Install dependencies AND the package itself
RUN poetry config virtualenvs.create false \
    && poetry install --no-interaction --no-ansi --only main

EXPOSE 8000
CMD ["python", "test-server/main.py"]