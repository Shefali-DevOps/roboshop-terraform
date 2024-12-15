dev-apply:
	rm -rf .terraform
	terraform init -backend-config=env-dev/state.tfvars
	terraform apply -var-file=env-dev/main.tfvars -auto-approve