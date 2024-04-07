ARG WORDPRESS_TAG="6.4-php8.3"

FROM wordpress:$WORDPRESS_TAG

ARG USER_ID=1000
ARG GROUP_ID=1000

# Dialout has the same GID as the staff group on macos, so we reassign it.
RUN groupmod -g 666 dialout && \
    usermod -u ${USER_ID} www-data && \
    groupmod -g ${GROUP_ID} www-data
