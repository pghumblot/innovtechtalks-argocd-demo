FROM python:3.9-slim

WORKDIR /app
COPY app.py .
RUN pip install flask

ENV MESSAGE="Hello from Docker image"
CMD ["python", "app.py"]

