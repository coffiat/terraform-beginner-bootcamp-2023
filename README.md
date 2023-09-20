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

### Working with Env Vars

We can list out all environment Variables using the `env` command

We can filter specific env vars using grep eg.`env| grep AWS`

In the terminal we can set using `export HELLO=' world`

In the terminal we unset using `unset HELLO`

We can temporarily set en var by running a command

```sh
HELLO=`world ./bin/print_message
```

Within a bash script, we can set env whithout export eg.

```sh
#!/usr/bin/env bash

HELLO=`world`

echo $HELLO
```

#### Printing Vars

We can print an env var using eg.`echo $HELLO`

### Scoping of Env Vars

When you open a new bash terminals in VSCode, it will not be aware of env vars that you have set in another window.

If you want env Vars to persist accross all future bash terminals, you need to set env vars in your bash profile. eg.`.bash_profile`

#### Persisting Env Vars in Gitpod

We can persist Env Vars into gitpod b storing them in Gitpod Secrets Storage.

```

gp env HELLO='world'
```

All future workspaces launched will set the env vars for all bash terminals opened in those workspaces.

You can also set Enn Vars in `.gitpod.yml`, but it will only contain non sensitive information
