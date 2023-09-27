# Terraform Beginner Bootcamp 2023 - Week 0

- [Terraform Beginner Bootcamp 2023 - Week 0](#terraform-beginner-bootcamp-2023---week-0)
  * [Semantic Versioning](#semantic-versioning)
  * [Install The Terraform CLI](#install-the-terraform-cli)
    + [Considerations for Linux Distribution](#considerations-for-linux-distribution)
    + [Consideration of  the Terraform CLI changes](#consideration-of--the-terraform-cli-changes)
    + [Refactoring into Bash Scripts](#refactoring-into-bash-scripts)
      - [Shebang Considerations](#shebang-considerations)
      - [Execution Considerations](#execution-considerations)
      - [Linux Permissions Considerations](#linux-permissions-considerations)
    + [Gitpod lifecycle](#gitpod-lifecycle)
    + [Working with Env Vars](#working-with-env-vars)
    + [Printing Vars](#printing-vars)
    + [Scoping of Env Vars](#scoping-of-env-vars)
    + [Persisting Env Vars in Gitpod](#persisting-env-vars-in-gitpod)
  * [AWC CLI Installation](#awc-cli-installation)
  * [Terraform Basics](#terraform-basics)
    + [Terraform Registry](#terraform-registry)
    + [Terraform Console](#terraform-console)
      - [Terraform Init](#terraform-init)
      - [Terraform Plan](#terraform-plan)
      - [Terraform apply](#terraform-apply)
      - [Terraform Destroy](#terraform-destroy)
      - [Terraform Lock files](#terraform-lock-files)
      - [Terraform State Files](#terraform-state-files)
      - [Terraform Directory](#terraform-directory)
  * [Issues with Terraform Cloud Login and Gitpod Workspace](#issues-with-terraform-cloud-login-and-gitpod-workspace)


## Semantic Versioning

This project is going to utilize semantic versioning for its tagging.
[semver.org](https://semver.org/)

The general format:

 **MAJOR.MINOR.PATCH**, eg. `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward-compatible manner
- **PATCH** version when you make backward compatible bug fixes

## Install The Terraform CLI

### Considerations for Linux Distribution

This project is built against UBUNTU.
Consider checking the OS version in Linux

$ cat /etc/os-release

PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy

[Checking os version](https://support.ucsd.edu/its?id=kb_article_view&sysparm_article=KB0032481)

### Consideration of  the Terraform CLI changes

The terraform CLI installation instructions have changed due to gpg keyring changes. So we needed to refer to the latest install cli instruction via Terraform Documentation

-[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

Due to the depreciation issues  encountered while  updating the Terraform CLI gpg, bash script steps were a considerable amount of code. So we decided to create a bash script to install the Terraform CLI

### Refactoring into Bash Scripts
While fixing the Terraform CLI gpg depreciation issues we noticed that bash scripts steps were a considerable amount more code. So we decided to create a bash script to install the Terraform CLI
This bash script is located in [./bin/intall_terraform-cli](./bin/install_terraform_cli.sh)

-This  will keep the Gitpod Task file ([.gitpod.yml](.gitpod.yml)) tidy
-This facilitates the process of debugging  and executing  Terraform CLI manually.
-This will allow better portability for other projects that need to install Terraform CLI.

#### Shebang Considerations

A Shebang (sha-bang) tells the bash script what program will interpret the script. eg.`#!/bin/bash`
ChatGPT recommended this format instead for bash: `#!/usr/bin/env bash`

- for portability for different OS distributions
-will search for the user's PATH for the bash executable
[Shebang command](https://en.wikipedia.org/wiki/Shebang_(Unix))

#### Execution Considerations

When executing the bash script, we can use the `./` short-hand command to execute the bash script.

eg.` ./bin/install_terraform_cli`

If we are using a script in .gitpod.yml we need to point the script to a program to interpret it.
eg. `source ./bin/install_terraform_cli`

#### Linux Permissions Considerations

To make the bash scripts executable, we need to grant permission.

`chmod u+x ./bin/install_terraform_cli`

<https://en.wikipedia.org/wiki/Chmod>

### Gitpod lifecycle

The particularity with Gitpod is that we need to pay attention because when using the `init` it will not rerun if we restart an existing workspace
<https://www.gitpod.io/docs/configure/workspaces/tasks>

### Working with Env Vars

We can list out all environment Variables using the `env` command

We can filter specific env vars using grep eg.`env| grep AWS`

In the terminal, we can set using `export HELLO=' world`

In the terminal, we unset using `unset HELLO`

We can temporarily set en var by running a command

```sh
HELLO=`world ./bin/print_message
```

Within a bash script, we can set env without export eg.

```sh
#!/usr/bin/env bash

HELLO=`world`

echo $HELLO
```

### Printing Vars

We can print an env var using eg.` echo $HELLO`

### Scoping of Env Vars

When you open a new bash terminal in VSCode, it will not be aware of the env vars that you have set in another window.

If you want env Vars to persist across all future bash terminals, you need to set env vars in your bash profile. eg.`.bash_profile`

### Persisting Env Vars in Gitpod

We can persist Env Vars into Gitpod B storing them in Gitpod Secrets Storage.

```

gp env HELLO='world'
```

All future workspaces launched will set the env vars for all bash terminals opened in those workspaces.

You can also set Enn Vars in `.gitpod.yml`, but it will only contain nonsensitive information

## AWC CLI Installation

AWS CLI is installed for the project via the bash script [`./bin/install_aws_cli`](./bin/install_aws_cli)

[Getting AWS CLI installed](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
[AWS CLI Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

We can check if AWS is configured correctly by running the following AWS CLI command:
```sh
aws sts get-caller-identity
```
If it is successful, you should see a JSON payload return that looks like this:

```json
{
    "UserId": "AIDA2PB7J7TQ6KDLVSVRK",
    "Account": "719539797217",
    "Arn": "arn:aws:iam::719539797217:user/Terraform-bootcamp"
}
```


We will need to generate AWS CLI credits from IAM users in order to use AWS CLI.

## Terraform Basics

### Terraform Registry

Terraform sources its providers and modules from the Terraform registry which is located at [registry.terraform.io](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string)

-**Providers** are interfaces to APIs that will allow you to create resources in Terraform.
-**Modules** are a way to make large amounts of terraform code modular, portable, and sharable.
[random terraform provider](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string)

### Terraform Console

We can see a list of all the terraform commands by simply typing `terraform`

#### Terraform Init

At the start of a new terraform project, we will always run `terraform init` to download the binaries for the terraform providers that we'll use in the project. 

#### Terraform Plan

`terraform plan`
This will generate the changeset about the state of our infrastructure and what will be changed

#### Terraform apply

`terraform apply`

This will run a plan and pass the changeset to be executed by terraform. Apply should prompt yes or no.

While creating the bucket name, it did not allow an upper case letter in the name, so we had to go back to the documentation to make sure we were on the right path.

[bucket naming rule](https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html)

If we want to automatically approve an apply, we can provide the auto approve flag eg. `terraform apply --auto-approve`

#### Terraform Destroy

`terraform destroy`

This will destroy resources.
You can also use the auto-approve to avoid typing yes after the terraform destroy command

#### Terraform Lock files

`.terraform.lock.hcl` contains the locked versioning for the providers or modules that should be used with this project.

The terraform Lock file should be committed to your Version control system (VSC) eg. Github

#### Terraform State Files

`.terraform.tfstate` contains information about the current state of your infrastructure

This file **should not be committed** to your VCS.

This file contains sensitive data.

If you lose this file, you lose knowing the state of your infrastructure

#### Terraform Directory

`.terraform` directory contains binaries of terraform providers.

## Issues with Terraform Cloud Login and Gitpod Workspace

When trying to log in to `terraform login` it launched bash view to generate a token. However, when proceeding, it did not work

The workaround is to manually generate a token in Terraform Cloud

`https://app.terraform.io/app/settings/tokens?source=terraform-login`


Then create open the file manually here:

```sh
touch /home/gitpod/.terraform.d/credentials.tfrc.json
open /home/gitpod/.terraform.d/credentials.tfrc.json
```

Provide the following code (replace your token in the file):

```json
{
  "credentials": {
    "app.terraform.io": {
      "token": "YOUR-TERRAFORM-CLOUD-TOKEN"
    }
  }
}
```
We have automated this workaround with the following bash script [bin/generate_tfrc_credentials](bin/generate_tfrc_credentials)


