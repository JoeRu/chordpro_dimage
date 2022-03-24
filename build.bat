docker build -t chordpro:latest ./latest
docker tag chordpro:latest jayar79/chordpro:latest
docker push jayar79/chordpro:latest

docker build -t chordpro:dev ./dev
docker tag chordpro:dev jayar79/chordpro:dev
docker push jayar79/chordpro:dev

docker build -t chordpro:master ./master
docker tag chordpro:master jayar79/chordpro:
docker push jayar79/chordpro:master