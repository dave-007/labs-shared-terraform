provider "aws" {
  version = "~> 2.0"
  region  = "us-west-2"
}

resource "random_string" "ide_id" {
  length  = 8
  special = false
}

resource "aws_cloudformation_stack" "lab_ide" {
  name          = "lab-ide-${random_string.ide_id.result}"
  template_body = <<STACK
{
  "Resources": {
    "LabIDE": {
      "Type": "AWS::Cloud9::EnvironmentEC2",
      "Properties": {
        "InstanceType": "t2.nano",
        "Name": "Lab IDE",
        "Description": "${var.description}",
        "Repositories": [
          {
            "PathComponent": "${var.path_component}",
            "RepositoryUrl": "${var.repository_url}"
          }
        ]
      }
    }
  }
}
STACK
}
