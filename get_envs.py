try:
    from azure.identity import AzureCliCredential
    from azure.keyvault.secrets import SecretClient
except ModuleNotFoundError:
    print("Error: Sorry, you've not got a valid installation of the azure-identity or azure-keyvault-secrets package."
          " Please address this and try again.")
    exit()
from azure.core.exceptions import ClientAuthenticationError
import logging
import sys


def reduce_logging_verbosity(logger):
    # this is used to remove all the issues azure flags up about not being logged into azure cli.
    # the complexity is due to Azure errors not being standard catchable exceptions.
    logger.setLevel(logging.CRITICAL)
    handler = logging.StreamHandler(stream=sys.stdout)
    logger.addHandler(handler)
    return logger


logger = reduce_logging_verbosity(logging.getLogger('azure.identity'))

# get creds from existing azure cli session
credential = AzureCliCredential()
key_vault_url = f'https://pip-ss-kv-stg.vault.azure.net'
keyvault_client = SecretClient(vault_url=key_vault_url, credential=credential)
print('Azure Credentials Grabber')

try:
    # try block checks for azure cli login status. If an error is returned from azure, client errors quickly.
    tenant_id = keyvault_client.get_secret("app-tenant-id").value
except ClientAuthenticationError:
    print("Error: You're not currently logged in to azure. Please sign in using the 'az login' command then try again.")
    exit()

email = input("Enter your email for publication services: ")

conn_str = 'DefaultEndpointsProtocol=http;AccountName=devstoreaccount1;AccountKey' \
           '=Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==;BlobEndpoint' \
           '=http://azurite:10000/devstoreaccount1;'

channel_management_keyvault = {
    'auto-pip-stg-courtel-api': 'COURTEL_API',
}

publication_services_keyvault = {
    'gov-uk-notify-api-key': 'NOTIFY_API_KEY',
    'courtel-certificate': 'THIRD_PARTY_CERTIFICATE',
}

data_management_keyvault = {}
subscription_management_keyvault = {}
account_management_keyvault = {
    'b2c-tenant-id': 'TENANT_GUID_B2C',
    'b2c-extension-app-id': 'EXTENSION_ID',
    'auto-pip-stg-pip-account-management-stg-id': 'CLIENT_ID_B2C',
    'auto-pip-stg-pip-account-management-stg-pwd': 'CLIENT_SECRET_B2C'
}
frontend_keyvault = {
    'app-pip-frontend-id': 'CLIENT_ID_INTERNAL',
    'app-pip-frontend-pwd': 'CLIENT_SECRET_INTERNAL',
    'b2c-tenant-id': 'TENANT_GUID',
    'auto-pip-stg-pip-frontend-stg-id': 'CLIENT_ID',
    'auto-pip-stg-pip-frontend-stg-pwd': 'CLIENT_SECRET',
}

urls = {'acc-man': 'ACCOUNT_MANAGEMENT_URL=http://account-management:6969/',
        'subs-man': 'SUBSCRIPTION_MANAGEMENT_URL=http://subscription-management:4550/',
        'data-man': 'DATA_MANAGEMENT_URL=http://data-management:8090/',
        'pub-servs': 'PUBLICATION_SERVICES_URL=http://publication-services:8081/',
        'chan-man': 'CHANNEL_MANAGEMENT_URL=http://channel-management:8181/',
        'frontend': 'FRONTEND_URL=https://localhost:8080'}

channel_management_hardcoded = [urls['acc-man'], urls['data-man'], urls['subs-man']]
publication_services_hardcoded = [urls['acc-man'], urls['data-man'], urls['chan-man'], urls['subs-man'],
                                  f'PI_TEAM_EMAIL={email}']
data_management_hardcoded = [urls['acc-man'], urls['chan-man'], urls['pub-servs'], urls['subs-man']]
subscription_management_hardcoded = [urls['data-man'], urls['chan-man'], urls['pub-servs'], urls['acc-man']]
account_management_hardcoded = [urls['pub-servs'], urls['subs-man'], urls['pub-servs'],
                                'IDENTITY_ISSUER=hmctspipnonprod.onmicrosoft.com',
                                'RUN_DB_MIGRATION_ON_STARTUP=true']
frontend_hardcoded = [
        urls['acc-man'][:-1], urls['data-man'][:-1], urls['subs-man'][:-1], urls['chan-man'][:-1],
    'AUTH_RETURN_URL=https://localhost:8080/login/return',
    'ADMIN_AUTH_RETURN_URL=https://localhost:8080/login/admin/return',
    'MEDIA_VERIFICATION_RETURN_URL=https://localhost:8080/media-verification/return',
    'B2C_ADMIN_URL=https://staff.pip-frontend.staging.platform.hmcts.net/pip-frontend.staging.platform.hmcts.net',
    'B2C_URL=https://sign-in.pip-frontend.staging.platform.hmcts.net/pip-frontend.staging.platform.hmcts.net',
    'CONFIG_ADMIN_ENDPOINT=https://staff.pip-frontend.staging.platform.hmcts.net/pip-frontend.staging.platform.hmcts'
    '.net/B2C_1_SignInAdminUserFlow/v2.0/.well-known/openid-configuration',
    'CONFIG_ENDPOINT=https://sign-in.pip-frontend.staging.platform.hmcts.net/pip-frontend.staging.platform.hmcts.net'
    '/B2C_1_SignInUserFlow/v2.0/.well-known/openid-configuration',
    'MEDIA_VERIFICATION_CONFIG_ENDPOINT=https://sign-in.pip-frontend.staging.platform.hmcts.net/pip-frontend.staging'
    '.platform.hmcts.net/B2C_1_SignInMediaVerification/v2.0/.well-known/openid-configuration',
    'OIDC=true',
    'SESSION_SECRET=abcdefg',
    'FRONTEND_URL=https://localhost:8080',
    'REDIS_HOST=redis',
    'REDIS_PORT=6379',
    'REDIS_LOCAL=true',
    f'TENANT_ID={tenant_id}'
]

repos = {'pip-channel-management': (channel_management_keyvault, channel_management_hardcoded,
                                    ('account-management', 'data-management')),
         'pip-publication-services': (publication_services_keyvault, publication_services_hardcoded,
                                      ('account-management', 'subscription-management', 'channel-management',
                                       'data-management')),
         'pip-data-management': (data_management_keyvault, data_management_hardcoded, (
             'channel-management', 'subscription-management', 'publication-services', 'account-management')),
         'pip-subscription-management': (subscription_management_keyvault, subscription_management_hardcoded, (
             'channel-management', 'data-management', 'publication-services', 'account-management')),
         'pip-account-management': (account_management_keyvault, account_management_hardcoded,
                                    ('channel-management', 'publication-services', 'subscription-management')),
         'pip-frontend': (frontend_keyvault, frontend_hardcoded,
                          ('data-management', 'account-management', 'subscription-management', 'channel-management'))}


def get_tenant_id_client_id_and_secret(f, filename):
    # needed by every repo except frontend which uses weird things
    client_id = keyvault_client.get_secret(f'app-{filename}-id').value
    client_secret = keyvault_client.get_secret(f'app-{filename}-pwd').value
    f.write(f'CLIENT_ID={client_id}\n')
    f.write(f'TENANT_ID={tenant_id}\n')
    f.write(f'CLIENT_SECRET={client_secret}\n')


def get_app_uri(f, filename):
    # needed by everything except frontend
    app_uri = keyvault_client.get_secret(f'app-{filename}-scope').value
    f.write(f'APP_URI={app_uri}\n')


az_api_keys = {service.upper().replace('-', '_'): keyvault_client.get_secret(f'app-pip-{service}-scope').value for
               service in ['account-management', 'data-management', 'subscription-management', 'channel-management',
                           'publication-services']}

for filename, repo in repos.items():
    with open(filename + '.env', 'w+') as f:
        if filename != 'pip-frontend':
            get_app_uri(f, filename)
            get_tenant_id_client_id_and_secret(f, filename)
        if filename in ['pip-channel-management', 'pip-data-management', 'pip-account-management']:
            f.write(f'CONNECTION_STRING={conn_str}\n')
        if filename in ['pip-data-management', 'pip-subscription-management', 'pip-account-management']:
            f.write(f'DB_HOST=postgres\nDB_PORT=5432\nDB_NAME=pip_db\nDB_USER=pip_user\nDB_PASS=pip_password\n')
        for key, value in repo[0].items():
            secret = keyvault_client.get_secret(key).value
            f.write(f'{value}={secret}\n')
        for hardcoded_secret in repo[1]:
            f.write(hardcoded_secret + '\n')
        for api_key in repo[2]:
            key = api_key.upper().replace('-', '_')
            f.write(f'{key}_AZ_API={az_api_keys[key]}\n')

