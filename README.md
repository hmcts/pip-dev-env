# pip-dev-env
Local development environment setup for the Court and Tribunal Hearings service (pip)

# Prerequisites

```
- Docker - latest version (seemingly not compatible with older versions)
- Docker Compose
- Azure CLI
```


# Setup

1. Clone the repository
2. Execute ```az login``` in the terminal and login to the correct Azure
3. Generate the environment variable files required for each service by running ```Make``` in you local repository. You will be prompted to enter your email. This may take up to <b>60 seconds</b> to generate
4. Execute ```build-deploy.sh``` which takes in the location of the other services repositories as an argument e.g. ```./build-deploy.sh /Users/test.user/IdeaProjects```
5. Create the required blob storage containers named ```files``` and ```artefact```
6. Add your existing account to the database or create a new one via the Account Management API (this is required first time to be able to login to the service)
