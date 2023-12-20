ARG NODE_VERSION=18-alpine
FROM --platform=$BUILDPLATFORM node:${NODE_VERSION} AS builder

# Set working directory
RUN mkdir -p /builder/{src,dist}
WORKDIR /builder/src

# Docker Metadata Actions
ARG DOCKER_META_IMAGES= \
    DOCKER_META_VERSION=

# Install dependencies and build application
RUN --mount=type=secret,id=GH_SORAMITSUKHMER_BOT_PAT \
    --mount=type=bind,target=.,readwrite=true \
<<EOF
    set -aeou pipefail
    CI=1
    CYPRESS_INSTALL_BINARY=0
    npm config set "//npm.pkg.github.com/:_authToken" "$(cat /run/secrets/GH_SORAMITSUKHMER_BOT_PAT)"
    yarn install --frozen-lockfile
    if ! `yarn run browserslist | grep "caniuse-lite is outdated"`; then
        npx browserslist@latest --update-db
    fi
    npm config delete "//npm.pkg.github.com/:_authToken"
    yarn build --dest /builder/dist
    npx generate-license-file --input package.json --output /builder/dist/third-party-licenses.txt
EOF

# WIP
