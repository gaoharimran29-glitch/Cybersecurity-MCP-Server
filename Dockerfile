FROM python:3.12-slim

# Install system dependencies including nmap
RUN apt-get update && \
    apt-get install -y --no-install-recommends nmap && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    which nmap && \
    nmap --version

WORKDIR /app

COPY requirements.txt .

# Force correct whois package
RUN pip uninstall whois -y || true && \
    pip install --no-cache-dir -r requirements.txt

COPY main.py .

EXPOSE 8000

CMD ["python", "main.py"]