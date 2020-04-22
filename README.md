# cross-account-role

This repository contains the terraform templates for creating AWS Namespaces. 

## Design

The major components are an unprivileged ${tenant}BuildAgent role in a central account that can assume privileged ${tenant}BuildAgent roles in other AWS accounts, and iam policies that grant the BuildAgent roles write access to various AWS resources.
For the (non-Chinese) Commons accounts, the central build agent roles are deployed in entsvcs-non and can assume roles in aws-sbx-commons1, aws-non-commons1 and aws-prd-commons1.

## Isolation Concepts
The Cloud Automation Team maintains a library of IAM policy templates designed to provided limited access to AWS resources. In general, each policy template contains everything needed to access that resource, both programatically and in the AWS Console, though there are various exceptions to that rule (of note, most of the IAM-related rules are in iam.tf and not duplicated in each policy).

The isolation mechanism varies per resource due to AWS inconsistencies. Please consult the policy templates under modules/managed-policies for individual details.

Some examples of isolation mechanisms
* limiting access to resources with ARNs that have the tenant namespace in the ARN
```
  resources = [
    arn:aws:iam::123456789:role/${namespace}-*"
  ]
```
* limiting access to resources based on resource tags
```
    resources = ["*"]

    condition {
      test     = "StringLike"
      variable = "rds:db-tag/Name"
      values   = ["${namespace}*"]
    }
```

## Important Caveat

MANY AWS RESOURCES CANNOT BE NAMESPACED!!!1!1eleventy
The list of AWS resources that cannot be restricted includes, but is not limited to, elasticache, APIGateway, and Cloudfront. Tenants with access to such resources are fully capable of wreaking havoc on other tenant's resources. Proceed with caution.

## Additional Information
* [CAT's AWS Commons Documentation](https://confluence.nike.com/display/CAT/AWS+Commons+Documentation)
* https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_actionsconditions.html
