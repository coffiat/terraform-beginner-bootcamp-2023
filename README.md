# Terraform Beginner Bootcamp 2023

## Semantic Versioning

This project is going to utilize semantic versioning for its tagging.
[semver.org](https://semver.org/)

The general format:

 **MAJOR.MINOR.PATCH**, eg. `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes


### Considerations fro linux Distribution

This project is built against UBUNTU.
Consider checking the OS version in Linux

[Checking os version](https://support.ucsd.edu/its?id=kb_article_view&sysparm_article=KB0032481)
### Consideration with  the Terraform CLI changes

The terraform CLI installation instruction have changed due to gpg keyring changes. So we needed to refer to the latest inctall cli instruction via Terraform Documentation

-[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)


Due to the depreciation issues  encounted while  updating the Terraform CLI gpg, bash script steps were a considerable amount of code. So we decided to create a bash script to install the Terraform CLI

This bash script is located in [./bin/intall_terraform-cli](./bin/install_terraform_cli.sh)

-This  will keep the Gitpod Task file ([.gitpod.yml](.gitpod.yml)) tidy
-This facilitate the process of deburging  and executing  terraform CLI manually.
-This will allow better portability for other projects that need to install Terraform CLI.

#### Shebang Considerations

A Shebang (sha-bang) tells the bash script what program that will interpret the script. eg.`#!/bin/bash`
ChatGPT recommended this format instead for bash: `#!/usr/bin/env bash`

- for portability for different OS distributions
-will search for the user's PATH for the bash executable

When executing the bash script, we can use the `./` short hand command to execute the bash script.
[Shebang command](https://en.wikipedia.org/wiki/Shebang_(Unix))


<https://en.wikipedia.org/wiki/Chmod>

<https://www.gitpod.io/docs/configure/workspaces/tasks>
