data "aws_iam_policy_document" "iot_pd" {
  //IoT Read
  statement {
    actions = [
      "iot1click:Describe*",
      "iot1click:Get*",
      "iot1click:List*",
      "iotanalytics:Describe*",
      "iotanalytics:Get*",
      "iotanalytics:List*",
      "iotanalytics:RunPipelineActivity",
      "iotanalytics:SampleChannelData",
      "iot:Describe*",
      "iot:Get*",
      "iot:List*",
      "iot:SearchIndex",
      "iot:TestAuthorization",
      "iot:TestInvokeAuthorizer",
      "iotevents:Describe*",
      "iotevents:Get*",
      "iotevents:List*",
      "iotsitewise:Describe*",
      "iotsitewise:Get*",
      "iotsitewise:List*",
    ]

    resources = ["*"]
  }

  //IoT Write *
  statement {
    actions = [
      "iot:TagResource",
      "iot:UntagResource",
      "iot:AcceptCertificateTransfer",
      "iot:AttachPrincipalPolicy",
      "iot:AttachThingPrincipal",
      "iot:CancelCertificateTransfer",
      "iot:ClearDefaultAuthorizer",
      "iot:Connect",
      "iot:Publish",
      "iot:Receive",
      "iot:Subscribe",
      "iot:CreateCertificateFromCsr",
      "iot:CreateKeysAndCertificate",
      "iot:CreateOTAUpdate",
      "iot:CreatePolicy",
      "iot:CreateStream",
      "iot:CreateTopicRule",
      "iot:DeleteRegistrationCode",
      "iot:DeleteTopicRule",
      "iot:DeleteV2LoggingLevel",
      "iot:DetachThingPrincipal",
      "iot:DisableTopicRule",
      "iot:EnableTopicRule",
      "iot:RegisterCACertificate",
      "iot:RegisterCertificate",
      "iot:RegisterThing",
      "iot:ReplaceTopicRule",
      "iot:SetLoggingOptions",
      "iot:SetV2LoggingLevel",
      "iot:SetV2LoggingOptions",
      "iot:StartThingRegistrationTask",
      "iot:StopThingRegistrationTask",
      "iot:UpdateCertificate",
      "iot:UpdateEventConfigurations",
      "iot:UpdateIndexingConfiguration",
      "iotanalytics:PutLoggingOptions",
      "iotevents:CreateDetectorModel",
      "iotevents:CreateInput",
      "iotevents:PutLoggingOptions",
    ]

    resources = ["*"]
  }

  //IoT
  statement {
    actions = [
      "iot:AddThingToBillingGroup",
      "iot:AddThingToThingGroup",
      "iot:AssociateTargetsWithJob",
      "iot:AttachPolicy",
      "iot:CancelJob",
      "iot:CancelJobExecution",
      "iot:CreateAuthorizer",
      "iot:CreateBillingGroup",
      "iot:CreateJob",
      "iot:CreatePolicyVersion",
      "iot:CreateRoleAlias",
      "iot:CreateThing",
      "iot:CreateThingGroup",
      "iot:CreateThingType",
      "iot:DeleteAuthorizer",
      "iot:DeleteBillingGroup",
      "iot:DeleteCACertificate",
      "iot:DeleteCertificate",
      "iot:DeleteJob",
      "iot:DeleteJobExecution",
      "iot:DeleteOTAUpdate",
      "iot:DeletePolicy",
      "iot:DeletePolicyVersion",
      "iot:DeleteRoleAlias",
      "iot:DeleteStream",
      "iot:DeleteThing",
      "iot:DeleteThingGroup",
      "iot:DeleteThingShadow",
      "iot:DeleteThingType",
      "iot:DeprecateThingType",
      "iot:DetachPolicy",
      "iot:DetachPrincipalPolicy",
      "iot:RejectCertificateTransfer",
      "iot:RemoveThingFromBillingGroup",
      "iot:RemoveThingFromThingGroup",
      "iot:SearchIndex",
      "iot:SetDefaultAuthorizer",
      "iot:SetDefaultPolicyVersion",
      "iot:StartNextPendingJobExecution",
      "iot:TestAuthorization",
      "iot:TestInvokeAuthorizer",
      "iot:TransferCertificate",
      "iot:UpdateAuthorizer",
      "iot:UpdateBillingGroup",
      "iot:UpdateCACertificate",
      "iot:UpdateJob",
      "iot:UpdateJobExecution",
      "iot:UpdateRoleAlias",
      "iot:UpdateStream",
      "iot:UpdateThing",
      "iot:UpdateThingGroup",
      "iot:UpdateThingGroupsForThing",
      "iot:UpdateThingShadow",
    ]

    resources = [
      "arn:${var.partition}:iot:*:${var.module_account_id}:client/${var.module_customer_namespace}*",
      "arn:${var.partition}:iot:*:${var.module_account_id}:index/${var.module_customer_namespace}*",
      "arn:${var.partition}:iot:*:${var.module_account_id}:job/${var.module_customer_namespace}*",
      "arn:${var.partition}:iot:*:${var.module_account_id}:thing/${var.module_customer_namespace}*",
      "arn:${var.partition}:iot:*:${var.module_account_id}:thinggroup/${var.module_customer_namespace}*",
      "arn:${var.partition}:iot:*:${var.module_account_id}:billinggroup/${var.module_customer_namespace}*",
      "arn:${var.partition}:iot:*:${var.module_account_id}:thingtype/${var.module_customer_namespace}*",
      "arn:${var.partition}:iot:*:${var.module_account_id}:topic/${var.module_customer_namespace}*",
      "arn:${var.partition}:iot:*:${var.module_account_id}:topicfilter/${var.module_customer_namespace}*",
      "arn:${var.partition}:iot:*:${var.module_account_id}:rolealias/${var.module_customer_namespace}*",
      "arn:${var.partition}:iam::${var.module_account_id}:role/${var.module_customer_namespace}*",
      "arn:${var.partition}:iot:*:${var.module_account_id}:authorizer/${var.module_customer_namespace}*",
      "arn:${var.partition}:iot:*:${var.module_account_id}:policy/${var.module_customer_namespace}*",
      "arn:${var.partition}:iot:*:${var.module_account_id}:cert/${var.module_customer_namespace}*",
      "arn:${var.partition}:iot:*:${var.module_account_id}:cacert/${var.module_customer_namespace}*",
      "arn:${var.partition}:iot:*:${var.module_account_id}:stream/${var.module_customer_namespace}*",
      "arn:${var.partition}:iot:*:${var.module_account_id}:otaupdate/${var.module_customer_namespace}*",
    ]
  }

  //IoT Analytics
  statement {
    actions = [
      "iotanalytics:BatchPutMessage",
      "iotanalytics:CancelPipelineReprocessing",
      "iotanalytics:CreateChannel",
      "iotanalytics:CreateDataset",
      "iotanalytics:CreateDatasetContent",
      "iotanalytics:CreateDatastore",
      "iotanalytics:CreatePipeline",
      "iotanalytics:DeleteChannel",
      "iotanalytics:DeleteDataset",
      "iotanalytics:DeleteDatasetContent",
      "iotanalytics:DeleteDatastore",
      "iotanalytics:DeletePipeline",
      "iotanalytics:SampleChannelData",
      "iotanalytics:StartPipelineReprocessing",
      "iotanalytics:TagResource",
      "iotanalytics:UntagResource",
      "iotanalytics:UpdateChannel",
      "iotanalytics:UpdateDataset",
      "iotanalytics:UpdateDatastore",
      "iotanalytics:UpdatePipeline",
    ]

    resources = [
      "arn:${var.partition}:iotanalytics:*:${var.module_account_id}:channel/${var.module_customer_namespace}*",
      "arn:${var.partition}:iotanalytics:*:${var.module_account_id}:dataset/${var.module_customer_namespace}*",
      "arn:${var.partition}:iotanalytics:*:${var.module_account_id}:datastore/${var.module_customer_namespace}*",
      "arn:${var.partition}:iotanalytics:*:${var.module_account_id}:pipeline/${var.module_customer_namespace}*",
    ]
  }

  //IoT Events
  statement {
    actions = [
      "iotevents:BatchPutMessage",
      "iotevents:DeleteDetectorModel",
      "iotevents:DeleteInput",
      "iotevents:UpdateDetectorModel",
      "iotevents:UpdateInput",
    ]

    resources = [
      "arn:${var.partition}:iotevents:*:${var.module_account_id}:detectorModel/${var.module_customer_namespace}*",
      "arn:${var.partition}:iotevents:*:${var.module_account_id}:input/${var.module_customer_namespace}*",
    ]
  }
}

