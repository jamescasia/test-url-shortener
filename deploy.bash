set -o allexport
source .env
set +o allexport

docker build --platform $PLATFORM -t $IMAGE_PATH .
echo ">>>>>>>>> Image built! <<<<<<<<<<<"
docker push $IMAGE_PATH
echo ">>>>>>>>> image pushed to artifact hub <<<<<<<<<<<"
echo ">>>>>>>>> deploying <<<<<<<<<<<"
gcloud run deploy url-shortener-service \
  --image $IMAGE_PATH \
  --platform managed \
  --region asia-southeast1 \
  --allow-unauthenticated \
  --add-cloudsql-instances $CLOUDSQL_CONNECTION_NAME \
  --service-account $SERVICE_ACCOUNT
echo ">>>>>>>>>>> deployed <<<<<<<<<<<<<"

# granting permissions
gcloud projects add-iam-policy-binding $GOOGLE_CLOUD_PROJECT \
  --member="serviceAccount:$SERVICE_ACCOUNT" \
  --role="roles/cloudsql.client"
