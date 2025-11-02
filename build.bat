docker image prune -f
#docker build -t chordpro:dev_container ./dev_container
#docker tag chordpro:dev_container jayar79/chordpro:dev_container
#docker push jayar79/chordpro:dev_container
docker buildx build --push -t jayar79/chordpro:dev_container ./dev_container

#docker build --no-cache -t chordpro:dev ./dev
#docker tag chordpro:dev jayar79/chordpro:dev
#docker push jayar79/chordpro:dev
docker buildx build --push -t jayar79/chordpro:dev ./dev

#docker build -t chordpro:latest ./latest
#docker tag chordpro:latest jayar79/chordpro:latest
#docker push jayar79/chordpro:latest
docker buildx build --push -t jayar79/chordpro:latest ./latest
