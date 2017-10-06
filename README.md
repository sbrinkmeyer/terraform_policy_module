# managed-policies
This repo contains the managed IAM policies for AWS Namespace Isolation

still emerging and evolving and changing

there are many opinions expressed in the creation and use of accounts/vpcs wired in to the configuration of the variables/policies

the modules templated as HCL makes it easy to just use tform variables to automatically make the json policy
downside is
you can only have 10 policies attached (each of which can only be 5k characters) and n number of inline policies injected, all of which can only total up to 10k characters.  so what to do?

1 use the templating bit from tform to create templated json data islands that represent the tenant customized policies then have an out of band process that uses the terraform.tfvars to determine the required policies, then "pack" them together in to logical units up to 5k character big and name these "TENANT-packed[0-9]" which in turn are deployed (in addition to all of [or just the request list] of aws services), and attached to the TENANT-sso role.
2 a second use will allow iteration of multi-region/multi-account for finer grained access as well as multiple resources that can't be splated (as in the efs requiring an ID.  so in a non-production account where a tenant needs a dev|qa|uat efs, you will need 3 ids, that are allowed through the efs policy which the hcl currently does not do)

so if you have a small service base then stay with the hcl declaration.  if not stay tuned as i'm working the template version as well.  :)
