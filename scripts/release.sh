#!/bin/bash

RED="\033[0;31m";
GREEN="\033[0;32m";
BLUE="\033[0;34m";
END_COLOR="\033[0m";

function avalog() {
  message=${1};

  echo -e "${GREEN}[Avalon]${END_COLOR} - $(date +"%m-%d-%Y, %r") - ${message}";
}

function bootstrap() {
  NPM_AUTH_TOKEN=${1};

  if [[ -z ${NPM_AUTH_TOKEN} ]]
  then
    avalog "${RED}Authorization token not found. Create a valid authorization token and store it in the project's secrets as NPM_AUTH_TOKEN. Read more at https://docs.npmjs.com/creating-and-viewing-access-tokens.${END_COLOR}";
    exit 1;
  fi

  avalog "${GREEN}📦 Preparing to release...${END_COLOR}";

  # ███████╗███████╗████████╗██╗   ██╗██████╗ 
  # ██╔════╝██╔════╝╚══██╔══╝██║   ██║██╔══██╗
  # ███████╗█████╗     ██║   ██║   ██║██████╔╝
  # ╚════██║██╔══╝     ██║   ██║   ██║██╔═══╝ 
  # ███████║███████╗   ██║   ╚██████╔╝██║     
  # ╚══════╝╚══════╝   ╚═╝    ╚═════╝ ╚═╝

  projectName="fwl-react-use-cleanup";
  imageName="${projectName}-release-image";
  dockerFilePath="./docker/release.Dockerfile";
  containerName="${projectName}-release-container";

  # ███████╗██╗  ██╗███████╗ ██████╗██╗   ██╗████████╗██╗ ██████╗ ███╗   ██╗
  # ██╔════╝╚██╗██╔╝██╔════╝██╔════╝██║   ██║╚══██╔══╝██║██╔═══██╗████╗  ██║
  # █████╗   ╚███╔╝ █████╗  ██║     ██║   ██║   ██║   ██║██║   ██║██╔██╗ ██║
  # ██╔══╝   ██╔██╗ ██╔══╝  ██║     ██║   ██║   ██║   ██║██║   ██║██║╚██╗██║
  # ███████╗██╔╝ ██╗███████╗╚██████╗╚██████╔╝   ██║   ██║╚██████╔╝██║ ╚████║
  # ╚══════╝╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚═════╝    ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝ 

  # Create an image to run a "release project" command.
  docker image build \
    --build-arg NPM_AUTH_TOKEN=${NPM_AUTH_TOKEN} \
    --file ${dockerFilePath} \
    --tag ${imageName} \
    .;

  # Run the "release project" command container.
  docker container run \
    --rm \
    --name ${containerName} \
    ${imageName};
}

bootstrap $@;
