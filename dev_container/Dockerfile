# Update the VARIANT arg in devcontainer.json to pick a Perl version
ARG VARIANT=5
FROM perl:${VARIANT}

# Set environment variables early
ENV DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    AWV=0.71 \
    WXV=0.004

# Install system packages, locales, and build dependencies in a single layer
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        git \
        lilypond \
        zsh \
        locales \
        build-essential \
        libwxgtk3.2 \
        libwxgtk-media3.2 \
        libwxgtk-webview3.2 \
        mupdf \
        cpanminus \
        sudo \
        libanyevent-perl \
        libclass-refresh-perl \
        libcompiler-lexer-perl \
        libdata-dump-perl \
        libio-aio-perl \
        libjson-perl \
        libmoose-perl \
        libpadwalker-perl \
        libscalar-list-utils-perl \
        libcoro-perl \
        libxml-perl \
        libfile-homedir-perl \
        libfont-ttf-perl \
        libpdf-api2-perl \
        libobject-pad-perl \
        libimage-info-perl \
        libjson-pp-perl \
        libjson-xs-perl \
        libmodule-pluggable-perl \
    && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && locale-gen en_US.UTF-8 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Build and install abcm2ps from source
RUN curl -o /tmp/abcm2ps.tar.gz https://codeload.github.com/lewdlime/abcm2ps/tar.gz/refs/tags/v8.14.15 \
    && tar -xzf /tmp/abcm2ps.tar.gz -C /tmp/ \
    && cd /tmp/abcm2ps-8.14.15 \
    && ./configure \
    && make \
    && make install \
    && cd / \
    && rm -rf /tmp/abcm2ps-8.14.15 /tmp/abcm2ps.tar.gz

# Install ChordPro dependencies and Perl modules from CPAN in batches
RUN cpanm --notest \
    App::Packager \
    File::HomeDir \
    File::LoadLines \
    Image::Info \
    PDF::API2 \
    String::Interpolate::Named \
    Text::Layout \
    Template \
    LaTeX::Encode \
    Pod::Usage \
    JavaScript::QuickJS \
    HarfBuzz::Shaper \
    XS::Parse::Sublike \
    Object::Pad \
    Data::Printer \
    ExtUtils::XSpp \
    JSON::Relaxed \
    Perl::LanguageServer

# Install Alien::wxWidgets separately as it requires a specific version
RUN cpanm --notest https://github.com/sciurius/perl-Alien-wxWidgets/releases/download/R0.71/Alien-wxWidgets-${AWV}.tar.gz

# Install ChordPro dependencies from git repo and clean up
RUN git clone https://github.com/ChordPro/chordpro.git /tmp/chordpro \
    && cd /tmp/chordpro \
    && cpanm --installdeps --notest . \
    && rm -rf /tmp/chordpro

# Create vscode user with sudo privileges and zsh as default shell
RUN groupadd --gid 1000 vscode \
    && useradd --uid 1000 --gid 1000 -m -s /bin/zsh vscode \
    && echo vscode ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/vscode \
    && chmod 0440 /etc/sudoers.d/vscode

# Install Oh My Zsh for vscode user and set locale
USER vscode
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended \
    && echo 'export LANG=en_US.UTF-8' >> /home/vscode/.zshrc \
    && echo 'export LANGUAGE=en_US:en' >> /home/vscode/.zshrc \
    && echo 'export LC_ALL=en_US.UTF-8' >> /home/vscode/.zshrc

USER root
WORKDIR /workspaces 

