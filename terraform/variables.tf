variable "aws_region" {
  default = "us-east-1"
}

variable "project_name" {
  default = "flask-express"
}

variable "flask_image" {
  default = "391829589857.dkr.ecr.us-east-1.amazonaws.com/flask-backend:v3"
}

variable "express_image" {
  default = "391829589857.dkr.ecr.us-east-1.amazonaws.com/express-frontend:v3"
}

