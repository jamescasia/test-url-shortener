

from google.cloud import secretmanager
import os

def get_secret(secret_name):
    # Instantiates a client
    client = secretmanager.SecretManagerServiceClient()

    # The project ID and secret ID
    project_id = os.getenv("GOOGLE_CLOUD_PROJECT")  # or specify the project ID directly
    secret_id = secret_name

    # Build the resource name of the secret
    secret_name = f"projects/{project_id}/secrets/{secret_id}/versions/latest"

    # Access the secret
    response = client.access_secret_version(name=secret_name)

    # The actual secret payload
    secret_payload = response.payload.data.decode("UTF-8")

    return secret_payload
