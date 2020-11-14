resource "aws_iam_role_policy" "terraform-politica-put-elmer" {
   name = "terraform-politica-put-elmer"
   role = aws_iam_role.terraform-rol-put-elmer.id

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
        {
          "Action": [
            "dynamodb:PutItem"
          ],
          "Effect": "Allow",
          "Resource": "*"
        }
      ]
  }
  EOF

}

resource "aws_iam_role" "terraform-rol-put-elmer" {
  name = "terraform-rol-put-elmer"

  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
  EOF
}

###############################################################################

resource "aws_iam_role_policy" "terraform-politica-edit-elmer" {
   name = "terraform-politica-edit-elmer"
   role = aws_iam_role.terraform-rol-edit-elmer.id

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
        {
          "Action": [
            "dynamodb:UpdateItem"
          ],
          "Effect": "Allow",
          "Resource": "*"
        }
      ]
  }
  EOF

}

resource "aws_iam_role" "terraform-rol-edit-elmer" {
  name = "terraform-rol-edit-elmer"

  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
  EOF
}

#################################################################################

resource "aws_iam_role_policy" "terraform-politica-read-elmer" {
   name = "terraform-politica-read-elmer"
   role = aws_iam_role.terraform-rol-read-elmer.id

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
        {
          "Action": [ 
            "dynamodb:Scan",
            "dynamodb:GetItem",
            "dynamodb:BatchGetItem"
          ],
          "Effect": "Allow",
          "Resource": "*"
        }
      ]
  }
  EOF

}

resource "aws_iam_role" "terraform-rol-read-elmer" {
  name = "terraform-rol-read-elmer"

  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
  EOF
}

#######################################################################################


resource "aws_iam_role_policy" "terraform-politica-delete-elmer" {
   name = "terraform-politica-delete-elmer"
   role = aws_iam_role.terraform-rol-delete-elmer.id

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
        {
          "Action": [ 
                    "dynamodb:DeleteItem"
          ],
          "Effect": "Allow",
          "Resource": "*"
        }
      ]
  }
  EOF

}

resource "aws_iam_role" "terraform-rol-delete-elmer" {
  name = "terraform-rol-delete-elmer"

  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
  EOF
}

output "arn_rol_put" {
  value = aws_iam_role.terraform-rol-put-elmer.arn
}

output "arn_rol_edit" {
  value = aws_iam_role.terraform-rol-edit-elmer.arn
}

output "arn_rol_read" {
  value = aws_iam_role.terraform-rol-read-elmer.arn
}

output "arn_rol_delete" {
  value = aws_iam_role.terraform-rol-delete-elmer.arn
}
