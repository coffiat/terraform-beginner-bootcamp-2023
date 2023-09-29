# Terraform Beginner Bootcamp 2023 - Week 1

## Root module structure

```
Our  root module structure is as follow:
PROJECT_ROOT
│
├── main.tf                # Everything else - varies based on your specific requirements
├── variable.tf            # Stores the structure of input variables
├── terraform.tfvars       # The data of variables we want to land into our Terraform project
├── providers.tf           # Defines required providers and their configuration
├── outputs.tf             # Stores our outputs
└── README.md              # Required for the root module
```



[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)
