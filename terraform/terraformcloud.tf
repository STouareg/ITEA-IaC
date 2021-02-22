terraform {
  backend "remote" {
    organization = "itea-study"

    workspaces {
      name = "ITEA-Exam-IaS"
    }
  }
}