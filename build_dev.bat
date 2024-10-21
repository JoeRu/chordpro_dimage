docker build -t chordpro:dev_container ./dev_container
docker tag chordpro:dev_container jayar79/chordpro:dev_container
docker push jayar79/chordpro:dev_container

docker build --no-cache -t chordpro:dev ./dev
docker tag chordpro:dev jayar79/chordpro:dev
docker push jayar79/chordpro:dev