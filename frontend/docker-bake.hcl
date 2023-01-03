target "docker-metadata-action" {}
target "github-metadata-action" {}
target "soramitsukhmer-metadata-action" {
  secret = [
    "id=github_pkg_token,env=GITHUB_PKG_TOKEN"
  ]
}

target "build" {
  inherits = ["docker-metadata-action", "github-metadata-action", "soramitsukhmer-metadata-action"]
  context = "./"
  dockerfile = "Dockerfile"
  platforms = [
    "linux/amd64",
    # "linux/arm64"
  ]
}
