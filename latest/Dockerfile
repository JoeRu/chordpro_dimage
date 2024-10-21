FROM jayar79/chordpro:dev_container

WORKDIR /tmp
RUN git clone https://github.com/ChordPro/chordpro.git

WORKDIR /tmp/chordpro
RUN cpanm --installdeps --notest .
RUN perl Makefile.PL && \
    make  && \
    make test  && \
    make install

WORKDIR /data
#ENTRYPOINT chordpro