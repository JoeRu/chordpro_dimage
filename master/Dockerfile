FROM jayar79/chordpro:latest

WORKDIR /tmp
RUN git clone https://github.com/ChordPro/chordpro.git

WORKDIR /tmp/chordpro
RUN cpanm --installdeps --notest .
RUN perl Makefile.PL && \
    make  && \
    make test  && \
    make install

# [Optional] Uncomment this section to install additional packages.
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends git lilypond

RUN curl -o /root/abcm2ps.tar.gz https://codeload.github.com/lewdlime/abcm2ps/tar.gz/refs/tags/v8.14.13 && \
    tar -xzf /root/abcm2ps.tar.gz -C /root/ 
WORKDIR /root/abcm2ps-8.14.13
RUN ./configure && \
    make && \
    make install

WORKDIR /data
#ENTRYPOINT chordpro