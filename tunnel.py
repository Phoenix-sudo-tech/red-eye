import subprocess
import time
import requests

# Kill any running ngrok
subprocess.call(['pkill', '-f', 'ngrok'])

# Start ngrok tunnel
subprocess.Popen(["./ngrok", "http", "8080"], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

# Wait for ngrok to initialize
time.sleep(3)

try:
    # Query the tunnel info
    tunnel_url = requests.get("http://localhost:4040/api/tunnels").json()['tunnels'][0]['public_url']
    print(f"\n🌐 Ngrok Public URL: {tunnel_url}")
except Exception as e:
    print("\n❌ Failed to get Ngrok public URL. Check if ngrok is running properly.")
    print(f"Error: {e}")
