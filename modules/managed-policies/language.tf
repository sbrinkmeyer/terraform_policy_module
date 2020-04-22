//language.tf
// Instead of providing separate policies for comprehend, translate, and transcribe just provide all NLP services in one policy.

data "aws_iam_policy_document" "language_pd" {
  statement {
    sid    = "Comprehend"
    effect = "Allow"

    actions = [
      "comprehend:BatchDetect*",
      "comprehend:Describe*",
      "comprehend:Detect*",
      "comprehend:List*",
      "comprehend:StartDominantLanguageDetectionJob",
      "comprehend:StartEntitiesDetectionJob",
      "comprehend:StartKeyPhrasesDetectionJob",
      "comprehend:StartSentimentDetectionJob",
      "comprehend:StartTopicsDetectionJob",
      "comprehend:StopDominantLanguageDetectionJob",
      "comprehend:StopEntitiesDetectionJob",
      "comprehend:StopKeyPhrasesDetectionJob",
      "comprehend:StopSentimentDetectionJob",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "Transcribe"
    effect = "Allow"

    actions = [
      "transcribe:GetTranscriptionJob",
      "transcribe:ListTranscriptionJobs",
      "transcribe:StartTranscriptionJob",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "Translate"
    effect = "Allow"

    actions = [
      "translate:TranslateText",
    ]

    resources = ["*"]
  }
}

