# metal-apac

Based on the scrum project within EMEA/APAC TAM.   Provisioning certain numbers of instances and vnf per your need.

## :watermelon: Instruction

This will provision an instance with your demand of the OS and the numbers on the project.
In the **terraform.tfvars** in the root module you may want to specify below as a variable.

[Metal_Instance]
- `project_id`       specify the project id you are in
- `nums`             specify the # of the instances you are about to provision
- `metro`            specify certain metro where you are about to provision
- `operating_system` specify required OS for the instance you are about to provision

[Network_Edge]
- `core_count` specify the core#
- `metro_code` specify metro code
- `notifications`  specify your email
- `package_code` specify package code
- `sec_metro_code` specify secondary vd's metro code
- `type_code` specify the device code
- `account_number` specify primary's account #
- `sec_account_number` specify secondary's account #
- `ver` specify the version of vd
- `usernamme` specify username for ssh
- `key_name` specify your registered publickey
- `acl_template_id` specify ACL id

*hostname*, *id*, and *public_ip* for both metal and NE will be shown per output upon completion of run.

It acts nothing more than above at the time writing the code today.   There will be more to come.

**terraform.tfvars** (sample)
```terraform
project_id         = "your_projectid"
nums               = 3
metro              = "sg"
operating_system   = "ubuntu_20_04"
core_count         = 2
metro_code         = "SG"
notifications      = ["name@equinix.com"]
package_code       = "network-essentials"
sec_metro_code     = "OS"
type_code          = "C8000V"
account_number     = "svc_account"
sec_account_number = "svc_account"
ver                = "17.06.01a"
username           = "username"
key_name           = "pubkey"
acl_template_id    = "uuid"
```  


>[!note]
>Declare your credential as environment variables before you run.  
>`export EQUINIX_API_CLIENTID=someEquinixAPIClientID`  
>`export EQUINIX_API_CLIENTSECRET=someEquinixAPIClientSecret`  
>`export METAL_AUTH_TOKEN=someEquinixMetalToken`
