# pip-dev-env
Local development environment setup for the Court and Tribunal Hearings service (pip)

# Prerequisites

```
- Docker - latest version (seemingly not compatible with older versions)
- Docker Compose
- Azure CLI
- Python (any installation over v3.7+ should be okay)
```

You'll also need to install the following python packages:
- azure-identity
- azure-keyvault-secrets

To do this, you'll need to use  ```pip3 install <package name>```
You can also use the built in requirements.txt parser in pycharm or whatever IDE you're using to automatically install these dependencies.

# Setup

1. Clone the repository
2. Execute ```az login``` in the terminal and login to the correct Azure
3. Run get_envs.py either in a virtual environment or on your main python installation (ensuring that you have installed the given python dependencies) 
4. Execute ```build-deploy.sh``` which takes in the location of the other services repositories as an argument e.g. ```./build-deploy.sh /Users/test.user/IdeaProjects```
5. Create the required blob storage containers named ```files``` ```artefact``` and ```publications```
6. Add your existing account to the database or create a new one via the Account Management API (this is required first time to be able to login to the service)
