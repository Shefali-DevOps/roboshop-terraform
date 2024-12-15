git pull
rm -rf .terraform
terraform init -backend-config=env-${1}/state.tfvars
terraform apply -var-file=env-{1}/main.tfvars -auto-approve