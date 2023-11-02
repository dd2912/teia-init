#!/bin/sh
#!/bin/bash

if [ $# -lt 1 ]; then
    echo "Usage: $0 </path/to/project>"
    exit 1
fi

# Define your container name and image name
CONTAINER_NAME="thiea"

# Check if the container exists and is running
if [ ! "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    if [ "$(docker ps -aq -f status=exited -f name=$CONTAINER_NAME)" ]; then
        # Remove the stopped container
        docker start \
        -i \
        $CONTAINER_NAME  \

    else

        docker run \
        -it \
        --privileged \
        --name $CONTAINER_NAME  \
        --userns=host \
        --net=host \
        --ipc=host \
        --gpus all \
        -e DISPLAY=$DISPLAY \
        -v /tmp/.X11-unix/:/tmp/.X11-unix:ro \
        -v $1:/datasets \
        -v /etc/passwd:/etc/passwd:ro \
        -v /etc/group:/etc/group:ro \
        -w /datasets  \
        theia:latest
    fi
fi
#docker stop $CONTAINER_NAME
#docker rm $CONTAINER_NAME
