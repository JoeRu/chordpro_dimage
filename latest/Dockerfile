# Update the VARIANT arg in devcontainer.json to pick a Perl version
ARG VARIANT=5
FROM perl:${VARIANT}

# [Optional] Uncomment this section to install additional packages.
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends git lilypond zsh

RUN curl -o /root/abcm2ps.tar.gz https://codeload.github.com/lewdlime/abcm2ps/tar.gz/refs/tags/v8.14.15 && \
    tar -xzf /root/abcm2ps.tar.gz -C /root/ 
WORKDIR /root/abcm2ps-8.14.15
RUN ./configure && \
    make && \
    make install
WORKDIR /

#Chordpro dependencys
RUN cpanm install App::Packager
RUN cpanm install File::HomeDir
RUN cpanm install File::LoadLines
RUN cpanm install Image::Info
RUN cpanm install PDF::API2
RUN cpanm install String::Interpolate::Named
RUN cpanm install Text::Layout
RUN cpanm install Template
RUN cpanm install LaTeX::Encode

#    https://github.com/richterger/Perl-LanguageServer
RUN apt install libanyevent-perl libclass-refresh-perl libcompiler-lexer-perl \
libdata-dump-perl libio-aio-perl libjson-perl libmoose-perl libpadwalker-perl \
libscalar-list-utils-perl libcoro-perl

#VS Code
RUN cpanm install Perl::LanguageServer 
