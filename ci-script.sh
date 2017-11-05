#! /bin/bash

VERSION=`curl https://storage.googleapis.com/kubernetes-release/release/stable.txt`

docker pull ganesshkumar/kubectl:$VERSION
exists=`$?`

if [[ exists == 0 ]]
then
    echo "Version $Version exists. Nothing to do"
else
    docker login --u $DOCKER_USERNAME -p $DOCKER_PASSWORD && \
        sed -i "s/{{VERSION}}/$VERSION/g" Dockerfile && \
        docker build -t ganesshkumar/kubectl:$VERSION . && \
        docker push ganesshkumar/kubectl:$VERSION && \
        docker tag ganesshkumar/kubectl:$VERSION ganesshkuamr/kubectl:latest && \
        docker push ganesshkumar/kubectl:latest && \
        echo "Created and pushed ganesshkumar/kubectl:$VERSION"
fi

