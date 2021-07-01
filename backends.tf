### root/project-A -----

terraform {
  backend "remote" {
    organization = "project-omago"

    workspaces {
      name = "omaga-dev"
    }
  }
}