# Chordpro Docker Images
This [Chordpro Docker Image Repository](https://github.com/JoeRu/chordpro_dimage) is the basis for the [Chordpro 0Docker-Image on docker.com : jayar79/chordpro](https://hub.docker.com/repository/docker/jayar79/chordpro).

Base workdir of the images is /data within the container. Mount your required path to it. The --rm option removes the container imidiatly when the job is done. 

Example usage:

    docker run --rm -v replace_with_your_path:/data jayar79/chordpro:master chordpro --help 
    docker run --rm -v replace_with_your_path:/data jayar79/chordpro:master chordpro test.cho -o testhtml
    docker run --rm -v replace_with_your_path:/data jayar79/chordpro:master lilypond --help
    docker run --rm -v replace_with_your_path:/data jayar79/chordpro:master abcm2ps

    docker run --rm -v replace_with_your_path:/data jayar79/chordpro:dev chordpro test.cho -o test.pdf

A not working example of a provided path with a config in a subdirectory. 
    docker run --rm -v /home/johan/mysongbook:/data jayar79/chordpro:master chordpro --config=/data/config/myconfig.json /data/*.cho --output mysongbook.pdf


bash (-it interactive terminal ) into the container:

    docker run -v replace_with_your_path:/data -it jayar79/chordpro:master /bin/zsh


usage with docker-compose provided with the docker-compose.yml:

    services:
    chordpro_image:
        image: jayar79/chordpro:master
        volumes:
        - ".:/data"
        - "/etc/localtime:/etc/localtime:ro"
        - "/etc/timezone:/etc/timezone:ro"


    docker compose run --rm chordpro_image chordpro --help  
    docker compose run --rm chordpro_image lilypond --help
    docker compose run --rm chordpro_image abcm2ps

## master

`master` image contains the master-branch of [chordpro](https://github.com/ChordPro/chordpro).
This image should be used in a productive environment.
Lilypond and abcm2ps are included as well.

## dev

`dev` image should contain the latest development of chordpro. As is did not have a PRO Account in docker hub. Rebuild is scheduled in Actions on a nightly base.

## latest

`latest`-tag just contains the prerequisites for using Chordpro and develop within - mainly intended to use with [VS Code and this repo-Image docker-build-image](https://github.com/JoeRu/chordpro_dev_env).

