#!/usr/bin/env bash

USER_NAME=${USER_NAME:-developer}
DATA_DIR=/opt/gitkraken/data
CONFIG_DIR=/opt/gitkraken/config

id -u ${USER_NAME} > /dev/null 2>&1
if [ $? -eq 1 ]; then
    # Check for unset environment variables
    if [[ -z ${USER_ID} || -z ${GROUP_ID} ]]; then
        echo "USER_ID and GROUP_ID environment variables must be set."
        exit 1
    fi

    # Create user
    groupadd -g ${GROUP_ID} ${USER_NAME}
    useradd -u ${USER_ID} -g ${GROUP_ID} --create-home ${USER_NAME} > /dev/null 2>&1
    chown ${USER_ID}:${GROUP_ID} /home/${USER_NAME}

    # Create/bind data directory
    mkdir -p ${DATA_DIR}
    chown ${USER_ID}:${GROUP_ID} ${DATA_DIR}
    gosu ${USER_NAME} ln -s ${DATA_DIR} /home/${USER_NAME}/data

    # Create/bind config directory
    mkdir -p ${CONFIG_DIR}
    chown ${USER_ID}:${GROUP_ID} ${CONFIG_DIR}
    gosu ${USER_NAME} ln -s ${CONFIG_DIR} /home/${USER_NAME}/.gitkraken
fi

gosu ${USER_NAME} "$@"
