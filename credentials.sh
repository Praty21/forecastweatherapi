client_id=$(curl -H "Authorization: Basic $base64encoded" "https://api.enterprise.apigee.com/v1/organizations/pratysin-97213-eval/apiproducts/forecast?query=list&entity=keys")

id=$(jq -r .[0] <<< "${client_id}" )
echo $id

client_secret=$(curl -H "Authorization: Basic $base64encoded" "https://api.enterprise.apigee.com/v1/organizations/pratysin-97213-eval/developers/pratysin@gmail.com/apps/forecastapp/keys/$id")

secret=$(jq -r .consumerSecret <<< "${client_secret}" )
echo $secret
