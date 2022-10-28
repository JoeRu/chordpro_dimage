docker build -t chordpro:latest ./latest
docker tag chordpro:latest jayar79/chordpro:latest
docker push jayar79/chordpro:latest

docker build --no-cache -t chordpro:dev ./dev
docker tag chordpro:dev jayar79/chordpro:dev
docker push jayar79/chordpro:dev