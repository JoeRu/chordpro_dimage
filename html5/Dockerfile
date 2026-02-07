FROM jayar79/chordpro:dev_container

WORKDIR /tmp
RUN git clone --branch html5 --single-branch https://github.com/JoeRu/chordpro.git

WORKDIR /tmp/chordpro
RUN git branch && git rev-parse HEAD
RUN cpanm --installdeps --notest .
RUN perl Makefile.PL && \
    make  && \
    make test  && \
    make install

WORKDIR /data
#ENTRYPOINT chordpro
