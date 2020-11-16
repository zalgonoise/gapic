#!/bin/zsh

oldPath=`pwd`
scriptPath=`realpath $0`
scriptPath=${scriptPath//test\/build.sh/}

cd ${scriptPath}


if [[ "$@" =~ "-b" ]]
then
    zsh ${scriptPath}/gapic.sh
fi


if ! [[ "$@" =~ "-c" ]]
then
    docker build -f test/dockerLocalBuild -t gapic:dev .
else 
    docker build -f test/dockerIncognitoBuild -t gapic:dev .
fi

cd ${oldPath}

docker run --rm -ti --name gapic_dev gapic:dev 