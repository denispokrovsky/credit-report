FROM python:3.11-slim

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    tesseract-ocr wget \
    && wget -q "https://github.com/tesseract-ocr/tessdata/raw/main/rus.traineddata" \
       -O /usr/share/tesseract-ocr/5/tessdata/rus.traineddata \
    && apt-get purge -y wget && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .
COPY logo.pn[g] ./

ENV GRADIO_SERVER_NAME="0.0.0.0"
EXPOSE 7860

CMD ["python", "-u", "app.py"]
