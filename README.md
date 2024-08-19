# metal-apac

Based on the scrum project within EMEA/APAC TAM.   Provisioning certain numbers of instances per your need.   also provision those networking setup within Metal portion.

## :watermelon: Instruction

This will provision a metal instance and vnf with your demand of the OS and the numbers on the project by leveraging modules from external. also provisions those components of BGP establishment with VNF.
In the **terraform.tfvars** in the root module you may want to specify below as a variable.

[Metal_Instance]
- `project_id`       specify the project id you are in
- `nums`             specify the # of the instances you are about to provision
- `metro`            specify certain metro where you are about to provision
- `operating_system` specify required OS for the instance you are about to provision

[BGP connectivity]
- `metro` where your baremetal lives in
- `vrf_desc` description of vrf entity
- `vrf_desc_sec` description of vrf sec entity 
- `vrf_name` name of vrf
- `vrf_name_sec` name of vrf sec
- `vrf_asn` ASN of vrf
- `vrf_ranges` IP ranges of vrf
- `vrf_ranges_sec` IP ranges of vrf sec
- `project_id` which your instance spinned up with
- `vlan_desc` description of metal vlan
- `vlan_desc_sec` description of metal vlan sec
- `range_desc` description of IP range
- `range_desc_sec` description of IP range sec
- `cidr` cidr of IP ranges you reserve
- `network_range` IP range itself

Above parameters are going to be utilized when establishing the BGP peer with VNF on another module.

**terraform.tfvars** (sample)
```terraform
project_id         = "your_projectid"
nums               = 3
metro              = "sg"
operating_system   = "ubuntu_20_04"
vrf_desc           ="sample"
vrf_name           ="sample"
vrf_asn            ="65000"
vrf_ranges         =["192.168.0.0/25", "192.168.1.0/25"]
project_id         ="your project_id"
vlan_desc          ="sample"
range_desc         ="sample"
cidr               =29
network_range      ="192.168.0.0"
```  


>[!note]
>Declare your credential as environment variables before you run.  
>`export EQUINIX_API_CLIENTID=someEquinixAPIClientID`  
>`export EQUINIX_API_CLIENTSECRET=someEquinixAPIClientSecret`  
>`export METAL_AUTH_TOKEN=someEquinixMetalToken`
