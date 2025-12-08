# Update the VARIANT arg in devcontainer.json to pick a Perl version
ARG VARIANT=5
FROM perl:${VARIANT}

# [Optional] Uncomment this section to install additional packages.
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends git lilypond zsh 

RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && locale-gen en_US.UTF-8

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

RUN curl -o /root/abcm2ps.tar.gz https://codeload.github.com/lewdlime/abcm2ps/tar.gz/refs/tags/v8.14.15 && \
    tar -xzf /root/abcm2ps.tar.gz -C /root/ 
WORKDIR /root/abcm2ps-8.14.15
RUN ./configure && \
    make && \
    make install
WORKDIR /
RUN rm -Rf /root/abcm2ps-8.14.15 && rm -f /root/abcm2ps.tar.gz


#Chordpro dependencys
RUN cpanm install App::Packager
RUN cpanm install File::HomeDir
# prerequisit to loadlines with errors
RUN cpanm install -f Test::Warnings
RUN cpanm install File::LoadLines
RUN cpanm install Image::Info
RUN cpanm install PDF::API2
RUN cpanm install String::Interpolate::Named
RUN cpanm install Text::Layout
RUN cpanm install Template
RUN cpanm install LaTeX::Encode

WORKDIR /tmp
RUN git clone https://github.com/ChordPro/chordpro.git

WORKDIR /tmp/chordpro
RUN cpanm --installdeps --notest .
RUN rm -Rf /tmp/chordpro

ARG AWV=0.71
ARG WXV=0.004

# Install perl and runtime packages.
# We have a libpdf-api2-perl but that's not recent enough.
# Also skip wxperl, we need a better version anyway.
RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y \
	  build-essential \
          perl \
	  libwxgtk3.2 \
	  libwxgtk-media3.2 \
	  libwxgtk-webview3.2 \
	  mupdf \
          cpanminus

# Install perl modules and clean up.
RUN apt-get install --no-install-recommends -y \
    libxml-perl \
    libfile-homedir-perl \
    libfont-ttf-perl \
    libpdf-api2-perl \
    libobject-pad-perl \
    libimage-info-perl \
    libjson-pp-perl \
    libjson-xs-perl \
    libmodule-pluggable-perl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Perl modules from CPAN.
RUN cpanm \
    https://github.com/sciurius/perl-Alien-wxWidgets/releases/download/R0.71/Alien-wxWidgets-${AWV}.tar.gz \
    Pod::Usage \
    JavaScript::QuickJS \
    File::LoadLines \
    String::Interpolate::Named \
    HarfBuzz::Shaper \
    Text::Layout \
    XS::Parse::Sublike \
    Object::Pad \
    Data::Printer \
    ExtUtils::XSpp


#    https://github.com/richterger/Perl-LanguageServer
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends libanyevent-perl libclass-refresh-perl libcompiler-lexer-perl \
    libdata-dump-perl libio-aio-perl libjson-perl libmoose-perl libpadwalker-perl \
    libscalar-list-utils-perl libcoro-perl    

# Create vscode user with sudo privileges
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends sudo \
    && groupadd --gid 1000 vscode \
    && useradd --uid 1000 --gid 1000 -m -s /bin/bash vscode \
    && echo vscode ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/vscode \
    && chmod 0440 /etc/sudoers.d/vscode

#VS Code
RUN cpanm install Perl::LanguageServer 

RUN rm -Rf /tmp
RUN mkdir /tmp
