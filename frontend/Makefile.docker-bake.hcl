variable "DOCKER_META_IMAGES" {}
variable "DOCKER_META_VERSION" {}

target "soramitsukhmer-metadata-action" {
  secret = [
    "id=github_pkg_token,env=GITHUB_PKG_TOKEN"
  ]
}

target "build"{
  inherits = [ "soramitsukhmer-metadata-action" ]
  context = "./"
  dockerfile = "Dockerfile"
  platforms = [ "linux/amd64" ]
  tags = [ "${DOCKER_META_IMAGES}:${DOCKER_META_VERSION}" ]
  args = {
    DOCKER_META_IMAGES = "${DOCKER_META_IMAGES}"
    DOCKER_META_VERSION = "${DOCKER_META_VERSION}"
  }
}
