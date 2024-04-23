# metal-apac

Based on the scrum project within EMEA/APAC TAM.   Provisioning certain numbers of instances per your need.

## :watermelon: Instruction

This will provision with your demand of the OS and the numbers on the project.
In the **main.tf** root module you may want to specify below as an augument.

- `project_id`       specify the project id you are in
- `nums`             specify the # of the instances you are about to provision
- `metro`            specify certain metro where you are about to provision
- `operating_system` specify required OS for the instance you are about to provision

It acts nothing more than above at the time writing the code today.   There will be more to come.

**main.tf** (sample)
```terraform
terraform {
  required_providers {
    equinix = {
      source = "equinix/equinix"
      version = "1.35.0"
    }
  }
}

module "instance" {
    source           = "./modules/metal_instance"
    project_id       = "your_project_id"
    nums             = 3
    metro            = "SG"
    operating_system = "ubuntu_20_04"
}
```  


>[!note]
>Declare your credential as environment variables before you run.  
>`export EQUINIX_API_CLIENTID=someEquinixAPIClientID`  
>`export EQUINIX_API_CLIENTSECRET=someEquinixAPIClientSecret`  
>`export METAL_AUTH_TOKEN=someEquinixMetalToken`
