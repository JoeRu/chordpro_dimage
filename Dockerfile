# Update the VARIANT arg in devcontainer.json to pick a Perl version
ARG VARIANT=5
FROM perl:${VARIANT}

# [Option] Install zsh
ARG INSTALL_ZSH="true"
# [Option] Upgrade OS packages to their latest versions
ARG UPGRADE_PACKAGES="true"

# Install needed packages and setup non-root user. Use a separate RUN statement to add your own dependencies.
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID
COPY library-scripts/*.sh /tmp/library-scripts/
RUN apt-get update \
    && /bin/bash /tmp/library-scripts/common-debian.sh "${INSTALL_ZSH}" "${USERNAME}" "${USER_UID}" "${USER_GID}" "${UPGRADE_PACKAGES}" "true" "true" \
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/library-scripts

# [Optional] Uncomment this section to install additional packages.
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends git lilypond

RUN curl -o /root/abcm2ps.tar.gz https://codeload.github.com/lewdlime/abcm2ps/tar.gz/refs/tags/v8.14.13 && \
    tar -xzf /root/abcm2ps.tar.gz -C /root/ 
WORKDIR /root/abcm2ps-8.14.13
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

#VS Code
RUN cpanm install Perl::LanguageServer 
