# docker-gitkraken

## How to use this image

Run the following command to create a container from this image.

```
docker create --name gitkraken \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e DISPLAY=$DISPLAY \
    -v <repos_directory>:/opt/gitkraken/data \
    -v <config_directory>:/opt/gitkraken/config \
    -e USER_ID=<user_id> \
    -e GROUP_ID=<group_id> \
    tlusk/docker-gitkraken
```

The container can then be started and restarted with the following command.

```
docker start gitkraken
```

### Hardware Accelerated OpenGL

This image has the vmware drivers for hardware accelerated OpenGL installed. In
order for this to work the following arguments need to be added when creating
the container.

```
--privileged -v=/dev/dri:/dev/dri:rw
```

The same will probably work with other OpenGL drivers as well but the image may
need to be extended to add the drivers if they are missing.

## Environment Variables

### `USER_ID`

This **required** environment variable sets the user id to run under inside the
image. Set this to the user id you want gitkraken to use when modifying files.

### `GROUP_ID`

This **required** environment variable sets the group id to run under inside the
image. Set this to the group id you want gitkraken to use when modifying files.

### `USER_NAME`

This optional environment variable can change the name of the user that runs
inside the container where the repos will be mapped to. It is does not affect
any functionality and is purely cosmetic.

## Issues

*"Use local SSH agent"* does not work, uncheck it and use the SSH functionality
built into GitKraken.