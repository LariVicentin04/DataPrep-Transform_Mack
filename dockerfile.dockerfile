
FROM python:3.9-slim

WORKDIR /app

COPY ./python/requirements.txt /app/requirements.txt

RUN pip install --no-cache-dir -r requirements.txt

COPY ./python /app

CMD ["python", "load.py"]
