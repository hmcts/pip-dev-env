.DEFAULT_GOAL := env

EMAIL := $(shell read -p "Enter your email for publication services: " secret ; echo $${secret})

env:
	echo TENANT_ID=$(shell az keyvault secret show --name "app-tenant-id" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-channel-management.env
	echo CLIENT_ID=$(shell az keyvault secret show --name "app-pip-channel-management-id" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-channel-management.env
	echo CLIENT_SECRET=$(shell az keyvault secret show --name "app-pip-channel-management-pwd" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-channel-management.env
	echo APP_URI=$(shell az keyvault secret show --name "app-pip-channel-management-scope" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-channel-management.env
	echo ACCOUNT_MANAGEMENT_AZ_API=$(shell az keyvault secret show --name "app-pip-account-management-scope" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-channel-management.env
	echo ACCOUNT_MANAGEMENT_URL=http://account-management:6969/ >> pip-channel-management.env
	echo SUBSCRIPTION_MANAGEMENT_URL=http://subscription-management:4550/ >> pip-channel-management.env
	echo COURTEL_API=$(shell az keyvault secret show --name "auto-pip-stg-courtel-api" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-channel-management.env
	echo DATA_MANAGEMENT_URL=http://data-management:8090/ >> pip-channel-management.env
	echo DATA_MANAGEMENT_AZ_API=$(shell az keyvault secret show --name "app-pip-data-management-scope" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-channel-management.env
	echo "CONNECTION_STRING=DefaultEndpointsProtocol=http;AccountName=devstoreaccount1;AccountKey=Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==;BlobEndpoint=http://azurite:10000/devstoreaccount1;" >> pip-channel-management.env

	echo TENANT_ID=$(shell az keyvault secret show --name "app-tenant-id" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-publication-services.env
	echo CLIENT_ID=$(shell az keyvault secret show --name "app-pip-publication-services-id" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-publication-services.env
	echo CLIENT_SECRET=$(shell az keyvault secret show --name "app-pip-publication-services-pwd" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-publication-services.env
	echo APP_URI=$(shell az keyvault secret show --name "app-pip-publication-services-scope" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-publication-services.env
	echo DATA_MANAGEMENT_AZ_API=$(shell az keyvault secret show --name "app-pip-data-management-scope" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-publication-services.env
	echo DATA_MANAGEMENT_URL=http://data-management:8090/ >> pip-publication-services.env
	echo NOTIFY_API_KEY=$(shell az keyvault secret show --name "gov-uk-notify-api-key" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-publication-services.env
	echo PI_TEAM_EMAIL=${EMAIL} >> pip-publication-services.env
	echo THIRD_PARTY_CERTIFICATE=$(shell az keyvault secret show --name "courtel-certificate" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-publication-services.env
	echo CHANNEL_MANAGEMENT_AZ_API=$(shell az keyvault secret show --name "app-pip-channel-management-scope" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-publication-services.env
	echo CHANNEL_MANAGEMENT_URL=http://channel-management:8181/ >> pip-publication-services.env

	echo TENANT_ID=$(shell az keyvault secret show --name "app-tenant-id" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-data-management.env
	echo CLIENT_ID=$(shell az keyvault secret show --name "app-pip-data-management-id" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-data-management.env
	echo CLIENT_SECRET=$(shell az keyvault secret show --name "app-pip-data-management-pwd" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-data-management.env
	echo APP_URI=$(shell az keyvault secret show --name "app-pip-data-management-scope" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-data-management.env
	echo SUBSCRIPTION_MANAGEMENT_AZ_API=$(shell az keyvault secret show --name "app-pip-subscription-management-scope" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-data-management.env
	echo ACCOUNT_MANAGEMENT_AZ_API=$(shell az keyvault secret show --name "app-pip-account-management-scope" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-data-management.env
	echo PUBLICATION_SERVICES_AZ_API=$(shell az keyvault secret show --name "app-pip-publication-services-scope" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-data-management.env
	echo DB_HOST=postgres >> pip-data-management.env
	echo DB_PORT=5432 >> pip-data-management.env
	echo DB_NAME=pip_db >> pip-data-management.env
	echo DB_USER=pip_user >> pip-data-management.env
	echo DB_PASS=pip_password >> pip-data-management.env
	echo "CONNECTION_STRING=DefaultEndpointsProtocol=http;AccountName=devstoreaccount1;AccountKey=Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==;BlobEndpoint=http://azurite:10000/devstoreaccount1;" >> pip-data-management.env
	echo SUBSCRIPTION_MANAGEMENT_URL=http://subscription-management:4550/ >> pip-data-management.env
	echo ACCOUNT_MANAGEMENT_URL=http://account-management:6969/ >> pip-data-management.env
	echo PUBLICATION_SERVICES_URL=http://publication-services:8081/ >> pip-data-management.env
	echo CHANNEL_MANAGEMENT_AZ_API=$(shell az keyvault secret show --name "app-pip-channel-management-scope" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-data-management.env
	echo CHANNEL_MANAGEMENT_URL=http://channel-management:8181/ >> pip-data-management.env

	echo TENANT_ID=$(shell az keyvault secret show --name "app-tenant-id" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-subscription-management.env
	echo CLIENT_ID=$(shell az keyvault secret show --name "app-pip-subscription-management-id" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-subscription-management.env
	echo CLIENT_SECRET=$(shell az keyvault secret show --name "app-pip-subscription-management-pwd" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-subscription-management.env
	echo APP_URI=$(shell az keyvault secret show --name "app-pip-subscription-management-scope" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-subscription-management.env
	echo DATA_MANAGEMENT_AZ_API=$(shell az keyvault secret show --name "app-pip-data-management-scope" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-subscription-management.env
	echo ACCOUNT_MANAGEMENT_AZ_API=$(shell az keyvault secret show --name "app-pip-account-management-scope" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-subscription-management.env
	echo CHANNEL_MANAGEMENT_AZ_API=$(shell az keyvault secret show --name "app-pip-channel-management-scope" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-subscription-management.env
	echo PUBLICATION_SERVICES_AZ_API=$(shell az keyvault secret show --name "app-pip-publication-services-scope" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-subscription-management.env
	echo DB_HOST=postgres >> pip-subscription-management.env
	echo DB_PORT=5432 >> pip-subscription-management.env
	echo DB_NAME=pip_db >> pip-subscription-management.env
	echo DB_USER=pip_user >> pip-subscription-management.env
	echo DB_PASS=pip_password >> pip-subscription-management.env
	echo DATA_MANAGEMENT_URL=http://data-management:8090/ >> pip-subscription-management.env
	echo ACCOUNT_MANAGEMENT_URL=http://account-management:6969/ >> pip-subscription-management.env
	echo PUBLICATION_SERVICES_URL=http://publication-services:8081/ >> pip-subscription-management.env
	echo CHANNEL_MANAGEMENT_URL=http://channel-management:8181/ >> pip-subscription-management.env

	echo TENANT_ID=$(shell az keyvault secret show --name "app-tenant-id" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-account-management.env
	echo CLIENT_ID=$(shell az keyvault secret show --name "app-pip-account-management-id" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-account-management.env
	echo CLIENT_SECRET=$(shell az keyvault secret show --name "app-pip-account-management-pwd" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-account-management.env
	echo APP_URI=$(shell az keyvault secret show --name "app-pip-account-management-scope" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-account-management.env
	echo PUBLICATION_SERVICES_AZ_API=$(shell az keyvault secret show --name "app-pip-publication-services-scope" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-account-management.env
	echo SUBSCRIPTION_MANAGEMENT_AZ_API=$(shell az keyvault secret show --name "app-pip-subscription-management-scope" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-account-management.env
	echo ACCOUNT_MANAGEMENT_AZ_API=$(shell az keyvault secret show --name "app-pip-account-management-scope" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-account-management.env
	echo CHANNEL_MANAGEMENT_AZ_API=$(shell az keyvault secret show --name "app-pip-channel-management-scope" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-account-management.env
	echo DB_HOST=postgres >> pip-account-management.env
	echo DB_PORT=5432 >> pip-account-management.env
	echo DB_NAME=pip_db >> pip-account-management.env
	echo DB_USER=pip_user >> pip-account-management.env
	echo DB_PASS=pip_password >> pip-account-management.env
	echo PUBLICATION_SERVICES_URL=http://publication-services:8081/ >> pip-account-management.env
	echo SUBSCRIPTION_MANAGEMENT_URL=http://subscription-management:4550/ >> pip-account-management.env
	echo RUN_DB_MIGRATION_ON_STARTUP=true >> pip-account-management.env
	echo IDENTITY_ISSUER=hmctspipnonprod.onmicrosoft.com >> pip-account-management.env
	echo "CONNECTION_STRING=DefaultEndpointsProtocol=http;AccountName=devstoreaccount1;AccountKey=Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==;BlobEndpoint=http://azurite:10000/devstoreaccount1;" >> pip-account-management.env
	echo CLIENT_ID_B2C=$(shell az keyvault secret show --name "auto-pip-stg-pip-account-management-stg-id" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-account-management.env
	echo CLIENT_SECRET_B2C=$(shell az keyvault secret show --name "auto-pip-stg-pip-account-management-stg-pwd" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-account-management.env
	echo TENANT_GUID_B2C=$(shell az keyvault secret show --name "b2c-tenant-id" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-account-management.env
	echo EXTENSION_ID=$(shell az keyvault secret show --name "b2c-extension-app-id" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-account-management.env

	echo TENANT_ID=$(shell az keyvault secret show --name "app-tenant-id" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-frontend.env
	echo CLIENT_ID=$(shell az keyvault secret show --name "auto-pip-stg-pip-frontend-stg-id" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-frontend.env
	echo CLIENT_SECRET=$(shell az keyvault secret show --name "auto-pip-stg-pip-frontend-stg-pwd" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-frontend.env
	echo ACCOUNT_MANAGEMENT_AZ_API=$(shell az keyvault secret show --name "app-pip-account-management-scope" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-frontend.env
	echo DATA_MANAGEMENT_AZ_API=$(shell az keyvault secret show --name "app-pip-data-management-scope" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-frontend.env
	echo SUBSCRIPTION_MANAGEMENT_AZ_API=$(shell az keyvault secret show --name "app-pip-subscription-management-scope" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-frontend.env
	echo CLIENT_ID_INTERNAL=$(shell az keyvault secret show --name "app-pip-frontend-id" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-frontend.env
	echo CLIENT_SECRET_INTERNAL=$(shell az keyvault secret show --name "app-pip-frontend-pwd" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-frontend.env
	echo TENANT_GUID=$(shell az keyvault secret show --name "b2c-tenant-id" --vault-name pip-ss-kv-stg --query "value" -o tsv) >> pip-frontend.env
	echo ACCOUNT_MANAGEMENT_URL=http://account-management:6969 >> pip-frontend.env
	echo DATA_MANAGEMENT_URL=http://data-management:8090 >> pip-frontend.env
	echo SUBSCRIPTION_MANAGEMENT_URL=http://subscription-management:4550 >> pip-frontend.env
	echo ADMIN_AUTH_RETURN_URL=https://localhost:8080/login/admin/return >> pip-frontend.env
	echo AUTH_RETURN_URL=https://localhost:8080/login/return >> pip-frontend.env
	echo MEDIA_VERIFICATION_RETURN_URL=https://localhost:8080/media-verification/return >> pip-frontend.env
	echo B2C_ADMIN_URL=https://staff.pip-frontend.staging.platform.hmcts.net/pip-frontend.staging.platform.hmcts.net >> pip-frontend.env
	echo B2C_URL=https://sign-in.pip-frontend.staging.platform.hmcts.net/pip-frontend.staging.platform.hmcts.net >> pip-frontend.env
	echo CONFIG_ADMIN_ENDPOINT=https://staff.pip-frontend.staging.platform.hmcts.net/pip-frontend.staging.platform.hmcts.net/B2C_1_SignInAdminUserFlow/v2.0/.well-known/openid-configuration >> pip-frontend.env
	echo CONFIG_ENDPOINT=https://sign-in.pip-frontend.staging.platform.hmcts.net/pip-frontend.staging.platform.hmcts.net/B2C_1_SignInUserFlow/v2.0/.well-known/openid-configuration >> pip-frontend.env
	echo MEDIA_VERIFICATION_CONFIG_ENDPOINT=https://sign-in.pip-frontend.staging.platform.hmcts.net/pip-frontend.staging.platform.hmcts.net/B2C_1_SignInMediaVerification/v2.0/.well-known/openid-configuration >> pip-frontend.env
	echo OIDC=true >> pip-frontend.env
	echo SESSION_SECRET=abcdefg >> pip-frontend.env
	echo FRONTEND_URL=https://localhost:8080 >> pip-frontend.env
	echo REDIS_HOST=redis >> pip-frontend.env
	echo REDIS_PORT=6379 >> pip-frontend.env
	echo REDIS_LOCAL=true >> pip-frontend.env