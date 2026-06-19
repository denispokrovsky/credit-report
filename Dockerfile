FROM python:3.11-slim

WORKDIR /app

# Install Tesseract OCR for scanned PDF recognition
RUN apt-get update && apt-get install -y --no-install-recommends \
    tesseract-ocr \
    wget \
    && wget -q "https://github.com/tesseract-ocr/tessdata/raw/main/rus.traineddata" \
       -O /usr/share/tesseract-ocr/5/tessdata/rus.traineddata \
    && apt-get purge -y wget && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy app files (logo.png is optional)
COPY app.py .
COPY logo.pn[g] ./

ENV GRADIO_SERVER_NAME="0.0.0.0"
ENV GRADIO_SERVER_PORT="7860"
EXPOSE 7860

CMD ["python", "-u", "app.py"]
