# Terraform Beginner Bootcamp 2023 - Week 1

## Fixing Tags

[How to delete remote and local tag in git](https://devconnected.com/how-to-delete-local-and-remote-tags-on-git/)

Locally delete tag

``` git tag -d <tag_name>
```

Remotely delete tag

```git push --delete origin tagname
```

Checkout the commit that you want to retag. Grab the sha from the Github history.

```sh
git checkout <sha>
git tag major minor pash
git push --tags
git checkout main
```

## Root module structure

Our  root module structure is as follow:

```PROJECT_ROOT
│
├── main.tf                # Everything else - varies based on your specific requirements
├── variable.tf            # Stores the structure of input variables
├── terraform.tfvars       # The data of variables we want to land into our Terraform project
├── providers.tf           # Defines required providers and their configuration
├── outputs.tf             # Stores our outputs
└── README.md              # Required for the root module
```

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Terraform and input variables

### Terraform Cloud Variables

We can set two kind of variables:

- Environment variables - those you would set in your bash terminal eg. AWS credentials
- terraform variables - those that you would normally set in your tfvars files

We can set terraform Cloud variable to be sensitive so they are not visible in the UI.

### Loading Terraform input variables

[Terrafom Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

### Var flag

We can use the `-var` flag to set an input variables or override a variable in the tfvars file eg. `terraform-var user_ud="my-user-id"`

### Var-file flag

According to chatGPT, the `-var.file` flag in terraform is used to specify a file containing variable value. which allows you to separate your variable value from your main terraform configuration files, providing a cleaner and more flexible way to manage configurations, especially across different environments. Most importantly, the `-var-file` flag is useful for keeping sensitive information separate, managing configurations for different environments, and making your terraform code more modular.

When running terraform commands with `-var-file`flag:

```terraform apply -var-file=variables.tfvars

```

### Terraform.tfvars

This is the default file to load in terraform variable in blunk

### Auto.tfvars

In the terraform , `auto.tfvars` is a special filename that is automatically loaded by terraform to set variable value. This is used to define default values for your variables without requiring explicit input on the command line or within the configuration files.

### Order of terraform variables

In terraform, the order of variable definitions in your configuration files doesn't matter. Terraform uses a two-step process for variable validation and assignment:

- declaration : variables are declared at the beginning of your terraform configuration files using the `variable`block.

.Example of variable declarations

```variable "region" {
  description = "The AWS region"
  type        = string
}

variable "instance_type" {
  description = "The EC2 instance type"
  type        = string
}
```

- assignment : variable value can be assigned through various methods such as command- line flags, variable files, environment variables, or default set within the configuration file

. Example of variable assignment

```provider "aws" {
  region = var.region
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = var.instance_type
}
```

In terraform, when a variable is defined in multiple place, the order of precedence determines which value is used.

## Dealing with configuration drift

## What happens if we lose our state file?

If you lose your state file, you most likely to have to tear down all your cloud infrastructure manually.

You can use terraform import but it will not work for all the cloud resources. You need to check the terraform providers documentation for which resources support import

### Fix Missing Resources with Terraform Import

`terraform import aws_s3_bucket.example`

[Terraform Inport](https://developer.hashicorp.com/terraform/language/import)

[AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#argument-reference)

### Fix Manual Configuration

Let assume that a new developper mistankly goes and delete or modifiy cloud resource manually through clickOps.

Running Terraform plan helps with attempt to put our infrastructure back into the expected state, fixing configuration drift.

## Fix using terraform Refresh

```sh
terraform apply -refresh-only -auto-approve
```

## Terrafom modules

### Terraform Module Structure

It is recommended to place in a `modules` directory when locally developing modules, but you can name it  whatever you like.

### Passing Input Variables

We can pass input variables to our module.
The module has to declare the terraform variables in its own variables.tf

```tf
module "terrahouse-aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
```

### Modules Sources

Using the source we can import the module from various places eg:
-locally
-Github
-Terraform Registry

```tf
module "terrahouse-aws" {
  source = "./modules/terrahouse_aws"
  }
```

[Modules Sources](https://developer.hashicorp.com/terraform/language/modules/sources)

## Consideration when using chatGPT to write Terraform

LLMS such as ChatGPT may not be trained on the latest documentation or information about Terraform.

It maylikely produce older example that could be deprecated. Often affecting providers.

## Working with  files in Terraform

### Fileexists function

This is a built in terraform function to check the existence of a file.

```condition  = fileexists(var.error-html_filepath)
```

[Fileexit function](https://developer.hashicorp.com/terraform/language/functions/fileexists)

### Filemd5

[file.md](https://developer.hashicorp.com/terraform/language/functions/filemd5)

### Path Variable

In Terraform there is a special variable called `path` that allows us to reference local path:

- path.module = get the path for the current module
- path.root = get the path for the root module

[Special Path variable](https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info)

 resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = "${path.root}/public/index.html"
 }

## Terraform Locals

Locals allow us to define locals variables. It can be very useful when we need to transform data into another format and have them referenced. 
```tf
locals {
    s3_origin_id="MyS3origin"
}
```

[Locals Values](https://developer.hashicorp.com/terraform/language/values/locals)

## Terraform Data sources

This allows use to source data from cloud resources.

This is useful when we want to reference cloud resources without importing them

```
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
```

[Data Sources](https://developer.hashicorp.com/terraform/language/data-sources)

## Working with JSON

We used the jsonencode to create the json policy inline in the hcl

```tf
> jsonencode({"hello"="world"})
{"hello":"world"}

```

[jsonencode](https://developer.hashicorp.com/terraform/language/functions/jsonencode)

### Changing the lifecycle of Resources

[Meta Arguments Lifecycle](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)

## Terraform Data

Plain data values such as Local Values and Input Variables don't have any side-effects to plan against and so they aren't valid in replace_triggered_by. You can use terraform_data's behavior of planning an action each time input changes to indirectly use a plain value to trigger replacement.

[T](https://developer.hashicorp.com/terraform/language/resources/terraform-data)

## Provisionners

Provisionners allow you to execute command on compute instances eg. a AWS CLI command.

They are not recommanded for use by Hoshicorp because Configuration Management tools such as ansible are a better fit, but the functionality exists

[Provisionners](https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax)

### Local-exec

This weill execute the command on the machine running the Terraform command eg. plan apply

```tf
resource "aws_instance" "web" {
  # ...

  provisioner "local-exec" {
    command = "echo The server's IP address is ${self.private_ip}"
  }
}
```

https://developer.hashicorp.com/terraform/language/resources/provisioners/local-exec

### Remote-exec

This will execute commands on a machine which you target. You will need to provide credentials such as ssh to get into the machine.

```tf
resource "aws_instance" "web" {
  # ...

  # Establishes connection to be used by all
  # generic remote provisioners (i.e. file/remote-exec)
  connection {
    type     = "ssh"
    user     = "root"
    password = var.root_password
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "puppet apply",
      "consul join ${aws_instance.web.private_ip}",
    ]
  }
}
```

https://developer.hashicorp.com/terraform/language/resources/provisioners/remote-exec
