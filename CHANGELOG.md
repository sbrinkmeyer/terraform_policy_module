# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

Canon [AWS Reference Information](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference.html)

Dates are YYYY-MM-DD

## [Unreleased]
- [CAT-1658] Fix templating of iam roles so that permissions actually work in China.
- [CAT-1652] Enable usage of provisioned concurrency on lambda

## [3.11.0] - 2019-12-20
- [CAT-1634] Add service role policy AmazonECSTaskExecutionRolePolicy

## [3.10.1] - 2019-12-18
- [CAT-NNNN] more fixes for the China partition
- [CAT-NNNN] Cerberus policy removed from always policies.  THIS IS A BREAKING CHANGE!

## [3.10.0] - 2019-12-18
- [CAT-1617] Add list access to internal.thecommons\* S3 bucket root and private-keys folder
- [CAT-NNNN] fixed the partition for the readonly and support roles

## [3.9.0] - 2019-12-09
- [CAT-1590] add to dms

## [3.8.0] - 2019-11-05
- [CAT-1544] Add access to Data API

## [3.7.3] - 2019-10-28
- [CAT-1539] Add access to CloudWatch Logs Insights query

## [3.7.2] - 2019-10-24
- [CAT-1536] Add states:TagResource as splat action

## [3.7.1] - 2019-10-01
- [CAT-1492] Added Secrets Manager policies to inline support role

## [3.7.0] - 2019-09-26
- [CAT-1479] Update/Fix for Global-Table DynamoDB updates
- [CAT-1469] Add tenantData role

## [3.6.0] - 2019-08-28
- [CAT-1429] Update CloudFormation policy for ChangeSets

## [3.5.0] - 2019-08-23
- [CAT-1057] CodeDeploy
- [CAT-1384] Elastic Beanstalk.
- sns:TagResource/UntagResource, updated per

## [3.4.0] - 2019-08-19
- [CAT-1443] update of some datapipeline pieces
- [CAT-1438] Update ECS policy

## [3.3.0] - 2019-08-07
- [CAT-1357] Add X-Ray policy
- [CAT-1409] Add Execute API actions to API Gateway policy

## [3.2.0] - 2019-06-20
- [CAT-1348] Add cloudformation:DescribeStacks.  Also added in permissions surrounding changesets for cloudformation.

## [3.1.0] - 2019-06-14
- [CAT-1293] Enable support for provisioned EFS mode
- [CAT-1326] Add access to Performance Insights

## [3.0.0] - 2019-06-06
- [CAT-1102] Add policy for ResourceGroups
- [CAT-822] Add IoT policy
- [] Upgrading to Terraform 0.12

## [2.29.0] - 2019-04-23
- [SupportRole] Add support for athena and glue.  also create role if no clicky
- [CAT-1207] Add policy for Data Lifecycle Manager

## [2.28.0] - 2019-04-01
- [CAT-1184] Update elasticsearch policy to support inline upgrades of elasticsearch
- [CAT-1211] Update RDS Neptune permissions to recognize China partitions
- [CAT-1203] Allow Tag and Untag of Step Functions resources
- [CAT-1215] Allow dms:RemoveTagsFromResource on all resources

## [2.27.0] - 2019-03-21
- [CAT-1199] Update Neptune to use namespacing by default, but keep support for non-standard cluster names
- [CAT-1201] Restore some s3 permissions for non-standard bucket names that still start with a namespace.
- [] adding server-side encryption of s3 buckets

## [2.26.0] - 2019-03-18
- [CAT-1143] Add logs:UntagLogGroup to cloudwatch logs permissions.
- [CAT-1159] Add Neptune access in RDS policy
- [CAT-1173] Allow Tag and Untag of ECR resources
- [CAT-1176] Tag IAM Roles and Users that we create for our tenants.
- [CAT-1137] Put cloudformation back in base-inline, stop attaching cloudformation by default.
- [CAT-1180] Allow Tag and Untag of Firehose delivery streams

## [2.25.0] - 2019-02-28
- [CAT-1132] Fix issue from terraform deprecation of data.aws.region.current.
- [CAT-1122] Add ListTagsForResource for stepfunctions.  Added stepfunction RO permissions to our base_inline_ro policy
- [CAT-1112] Change EFS policy to be based entirely on tags
- [CAT-1109] Add SecretsManager policies required by terraform's `aws_secretsmanager_secret` resource
- [CAT-1108] Expose EFS, S3, and Route53 info through outputs.  This should make adding bucket policies easier from a tenant repo.
- [CAT-1103] Update Lamba policy with access to layers
- [CAT-1093] Add permissions for iam tagging for rules and users
- [CAT-1033] Create SageMaker policy
- [CAT-1026] BMX Integration -- allow tenants to use BuildAgentRole from BMX

## [2.24.0] - 2019-02-19
- [CAT-1069] Add DMS Read permissions to base inline RO policy
- [CAT-1068] Update APIGateway policy for AWS China compatibility

## [2.23.1] - 2019-02-14
- [CAT-1025] Add ability for tenants to create their own S3 buckets.

## [2.23.0] - 2019-01-28
- [CAT-842] Fix EFS in AWS China regions.

## [2.22.2] - 2019-01-28
- [CAT-1004] Update DMS policy to include a wildcard as part of resource Name tag

## [2.22.1] - 2019-01-09
- [CAT-835] Add get-console-screenshot permissions in both cli and console

## [2.22.0] - 2018-12-21
- [CAT-986] Update ECS policy to include ecr:ListTagsForResource

## [2.21.1] - 2018-12-11
- [CAT-985] Enable Service linked role API GW -- Needed if you want to deploy a multi-region API GW

## [2.20.1] - 2018-12-05
- [CAT-929] Add firehose:ListTagsForDeliveryStream to firehose policy.

## [2.20.0] - 2018-11-20
- [CAT-920] add the TENANT-ec2 policy to the sso role on clicky_clicky
- [CAT-851] initial release of dax updates for aws provider
- [CAT-888] Allow creating redshift service-linked-role

## [2.19.0] - 2018-10-25
- [NONE] Initial release of redshift
- [CAT-877] Fix Lambda tagging permissions
- [CAT-856] - Add AAA to `base_inline_policy` and `base_inline_ro_policy`, this should help with verification of AAA working in a namespace.
   - To fit this change in, ec2 stuff was removed from `base_inline_policy` and instead namespaces will get the ec2-policy just directly attached to their buildAgentRole and stuff

## [2.18.0] - 2018-09-20
- [NONE] Allow lambdas to release network interfaces
- [CAT-827] Fix vmimport to provide minimal permissions.
   - Currently customers can import images without this policy because all the needed permissions are in ec2.tf and s3.tf.  So right now, no customer needs this policy.  But if we go a different direction in our IAM policies this policy might become needed.
- [CAT-800] Allow listing EFS resources via GUI and allow GetConsoleOutput mainly for the Unix Team


## [2.17.0] - 2018-09-11
- [CAT-664] Allow multiregion EFS!
   - Note something about the implementaiton breaks terraform plan, in that plan won't dereference the resources behind a policy.  Which makes it hard to figure out what changes will actually apply durning a run...
- [CAT-792] Add "cloudwatch:PutMetricData" to cloudwatchlogs.tf and lambda.tf
- [CAT-813] Add translate inside of language.tf
- [CAT-814] Add comprehend and transcribe to language.tf
   - 813 and 814 were combined into language.tf since they all deal with Natural Language Processing.

## [2.16.0] - 2018-09-07
- CAT-783 Add S3 get/put bucket notifications in base and s3.tf
- CAT-630 Add DMS policy
- CAT-710 Add SSM policy
- CAT-473 Add support to read Amazon/AWS policies
- CAT-761 Fix vmimport.tf to also allow importexport

## [2.15.0] - 2018-08-24
- CAT-757 Add sts assumerole for `role/namespace-*` in iam.tf
- CAT-761 Change vmimport.tf to just grant access to a special subfolder where the vmimport role can load vm images from.
- CAT-764 Add Simple DB policies as SDB.
- CAT-202 Add EMR policy.

## [2.14.1] - 2018-08-06
- CAT-524: adding launch template actions to ec2 and base inlinie policies
- CAT-695 Update lambda permissions for concurrancy settings.
- CAT-719 Update Elasticache to just allow everything

## [2.14.0] - 2018-07-31
- CAT-690 Update Console Readonly policy to allow for dynamodb scanning and listing.
- CAT-700 Update Kinesis permissions to cover star resources.  This should also fix console permissions.

## [2.13.3] - 2018-07-24
- CAT-699 Fix GetTemplateSummary action

## [2.13.2] - 2018-07-20
- CAT-692 Add ec2:ModifyVolume permissions

## [2.13.1] - 2018-06-26
- CAT-649 Update for kinesis video stream
- CAT-607 Adding ecr lifecycle policy

## [2.13.0] - 2018-06-26
- CAT-607 Adding the ecr lifecycle policy management
- CAT-635 Added dynamodb:UpdateContinuousBackups and dynamodb:UpdateTimeToLive to dynamodb.tf
- CAT-653 Fixing where prefix_option applies in naming a bucket.  Now the pattern is `{namespace}-{prefix}{target_nickname}-{region_name}`  THIS IS A POSSIBLY BREAKING CHANGE!

## [2.12.0] - 2018-06-21
- CAT-649: Added KinesisAnalytics and Kinesis Firehose
- CAT-615: Added secretsmanager
- CAT-593: Enable detailed monitoring

## [2.11.4] - 2018-06-11
- CAT-604: Allow for unencrypted ec2 volumes in cn-north-1

## [2.11.3] - 2018-05-16
- CAT-278: Added vmimport for getting windows images imported to AWS

## [2.11.2] - 2018-05-16
- CAT-578: Include AmazonEC2ContainerServiceEventsRole in condition for accepted ARNs when attaching a policy.

## [2.11.1] - 2018-05-15
- CAT-570: Allow cloudformation to perform actions on the stack/EC2ContainerService-${namepsace}

## [2.11.0] - 2018-05-08
- CAT-561: Move cloudformation out of base_inline_policy and just attach ${namespace}-cloudformation-policy to the buildRole and the sso_role when clickyclicky=yes.

## [2.10.0] - 2018-05-07
- CAT-516: Add UpdateRoleDescription
- CAT-557: Add DynamoDB DescribeContinuousBackups to roles.

## [2.9.5] - 2018-05-03
### Added
- CAT-516: Add GetRolePolicy and GetUserPolicy IAM policies

## [2.8.5] - 2018-04-19
### Added
- CAT-522: add attach and detach ec2 permissions for ENI

## [2.8.4] - 2018-04-11
- AMQ added.  (Amazon Message Queue)

## [2.8.3] - 2018-04-09
### Fixed:
- CAT-415: added required access to the internal.thecommons*/public-keys folder

## [2.8.2] - 2018-04-06
### Added
- S3-altname: added the ability to put a prefix on the s3 bucket name.  allows for differentiation of tenants in commons and entsvcs.  the default is now ''.  to override add value to terraform.tfvars and pass to module
- Added: Access to AWS Personal Health Dashboard
### Fixed
- CAT-459: create/delete enis - wcpgw?
- CAT-415: Fixed problem with tenant access to the internal.thecommons* s3 bucket

## [2.8.1] - 2018-03-30
### Fixed
- CAT-415: Fixed problem with tenant access to the internal.thecommons* s3 bucket

## [2.8.0] - 2018-03-28
### Added
- CAT-415: Added namespaced tenant access to the internal.thecommons* s3 bucket to s3.tf

## [2.7.1] - 2018-03-22
### Fixed
- CAT-443: fixed a bug where tenants could create s3 buckets in their namespace

## [2.7.0] - 2018-03-22
### Added
- Added more depends_on statements for ordering
- Added support for 'clicky-clicky' console users

### Changed
- Restricted `s.<tenant>builduser` role to only be able to assume to the `<tenant>BuildAgentRole` as opposed to `*BuildAgentRole`

## [2.6.1] - 2018-03-19
### Fixed
 - Fixed incorrect actions for cloudformation IAM policy.

## [2.5.0] - 2018-03-09
### Added
- batch, datapipeline and glue policies are available. They are not namespaceable, use with caution. Also untested.

## [2.4.1] - 2018-02-27
### Fixed
 - Position of cloudformation statement within base_inline_policy.tf

## [2.4.0] - 2018-02-27
### Added
 - namespaced Step Functions policy

## [2.3.0] - 2018-02-26
### Fixed
 - Dependencies on iam policies for s.builduser
 - Security groups now must be tagged with the namespace to be modified, or deleted.

### Added
 - Cloudformation is now part of baseline policies as well as the always policies

## [2.2.1] - 2018-02-19
### Fixed
- s.builduser now set to assume buildrole in _this_ account, not to assume role in _entsvcs_ account

### Added
- changelog
- contribution guidelines
- readme

## [2.2.0] - 2018-02-16
### Fixed
- removed redundant iam:List${Thing} permissions.

### Added
- acm:deletecertificate to ${tenant}BuildAgentRole

## [ 2.1.0]
### Added
- permissions for dynamoDB autoscaling and backups
- write access to dynamoDB items in namespaced dynamoDB instances for SupportRole

## [2.0.0]
Initial changelog entry. Merged https://github.nike.com/cat-terraform/managed-policies into https://github.nike.com/cat-terraform/cross-account-role.
