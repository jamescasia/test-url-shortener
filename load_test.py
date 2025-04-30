import requests
from requests.auth import HTTPBasicAuth
import concurrent.futures
import time
import signal

# Config
URL = "https://urlly.jamescasia.com/urls"  # Replace with your endpoint
USERNAME = "admin"
PASSWORD = "dellAddEdifier"
CONCURRENCY = 160

running = True

def signal_handler(sig, frame):
    global running
    print("\nStopping...")
    running = False

signal.signal(signal.SIGINT, signal_handler)

def call_endpoint(i):
    try:
        response = requests.get(URL, auth=HTTPBasicAuth(USERNAME, PASSWORD))
        return f"Request {i} - Status: {response.status_code}"
    except Exception as e:
        return f"Request {i} - Error: {str(e)}"

def main():
    round_num = 0
    while running:
        round_num += 1
        print(f"\n▶ Round {round_num}")
        start = time.time()

        with concurrent.futures.ThreadPoolExecutor(max_workers=CONCURRENCY) as executor:
            futures = [executor.submit(call_endpoint, i) for i in range(CONCURRENCY)]
            for future in concurrent.futures.as_completed(futures):
                print(future.result())

        print(f"✅ Round {round_num} completed in {time.time() - start:.2f}s")

if __name__ == "__main__":
    main()
