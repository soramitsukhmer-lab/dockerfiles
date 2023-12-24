ARG NODE_VERSION=18-alpine
FROM harbor.sorakh.io/frontend/frontend-buildpack-nodejs:${NODE_VERSION} AS builder

# Set working directory
RUN mkdir -p /builder/{src,dist}
WORKDIR /builder/src

# Docker Metadata Actions
ARG DOCKER_META_IMAGES= \
    DOCKER_META_VERSION=

# Install dependencies and build application
RUN --mount=type=secret,id=GH_SORAMITSUKHMER_BOT_PAT \
    --mount=type=bind,target=.,readwrite=true \
    --mount=type=cache,target=/usr/local/share/.cache/yarn/v6 \
<<EOF
    set -aeou pipefail
    CI=1
    CYPRESS_INSTALL_BINARY=0
    GITHUB_TOKEN="$(cat /run/secrets/GH_SORAMITSUKHMER_BOT_PAT)"
    yarn install --frozen-lockfile
    if ! `yarn run browserslist | grep "caniuse-lite is outdated"`; then
        npx browserslist@latest --update-db
    fi
    yarn build --dest /builder/dist
    npx generate-license-file --input package.json --output /builder/dist/third-party-licenses.txt
EOF

FROM harbor.sorakh.io/frontend/frontend-runtime-static:stable-alpine

# Copy the application from builder stage
COPY --from=builder /builder/dist /var/www/public

# Transfer project rootfs
ADD rootfs /

# Web Platform Metadata
COPY <<-EOT /etc/WEB_PLATFORM_METADATA
    # Web Platform Metadata
    WEB_PLATFORM_VERSION=${DOCKER_META_VERSION}
EOT

# Webenv runtime environment
#
# This variables used by gomplate template renderer
# See rootfs/etc/gomplate/templates/config.env
ENV NBC_PLATFORM_ENV=local \
    NBC_PLATFORM_VERSION=X.X.X-untagged

