# metal-apac

Based on the scrum project within EMEA/APAC TAM.   Provisioning certain numbers of instances per your need.   also provision those networking setup within Metal portion.

## :watermelon: Instruction

This will provision a metal instance with your demand of the OS and the numbers on the project by leveraging modules from external. also provisions those components of BGP establishment with VNF.
In the **terraform.tfvars** in the root module you may want to specify below as a variable.

[Metal_Instance]
- `project_id`       specify the project id you are in
- `billing_cycle`    specify the billing cycle
- `nums`             specify the # of the instances you are about to provision
- `plan`             specify the server plan
- `metro`            specify certain metro where you are about to provision
- `operating_system` specify required OS for the instance you are about to provision

[BGP connectivity]
- `metro` where your baremetal lives in
- `vrf_desc` description of vrf pri entity
- `vrf_desc_sec` description of vrf sec entity 
- `vrf_name_pri` name of vrf pri
- `vrf_name_sec` name of vrf sec
- `vrf_asn` ASN of vrf
- `project_id` which your instance spinned up with
- `vlan_desc_pri` description of metal vlan pri
- `vlan_desc_sec` description of metal vlan sec
- `range_desc_pri` description of IP range pri
- `range_desc_sec` description of IP range sec
- `cidr` cidr of IP ranges you reserve
- `network_range_pri` IP range pri itself
- `network_range_sec` IP range sec itself

Above parameters are going to be utilized when establishing the BGP peer with VNF on another module.

**terraform.tfvars** (sample)
```terraform
project_id         = "your_projectid"
nums               = 3
metro              = "sg"
operating_system   = "ubuntu_20_04"
vrf_desc_pri      = "pri"
vrf_desc_sec      = "sec"
vrf_name_pri      = "pri"
vrf_name_sec      = "sec"
vrf_asn           = "65111"
vlan_desc_pri     = "pri"
vlan_desc_sec     = "sec"
range_desc_pri    = "pri"
range_desc_sec    = "sec"
cidr              = 30
network_range_pri = "192.168.0.0"
network_range_sec = "192.168.2.0"
```  


>[!note]
>Declare your credential as environment variables before you run.  
>`export EQUINIX_API_CLIENTID=someEquinixAPIClientID`  
>`export EQUINIX_API_CLIENTSECRET=someEquinixAPIClientSecret`  
>`export METAL_AUTH_TOKEN=someEquinixMetalToken`
