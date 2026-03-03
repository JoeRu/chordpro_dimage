{ pkgs ? import <nixpkgs> {} }:

let
  perl = pkgs.perl;
  perlPkgs = pkgs.perlPackages;
in
pkgs.mkShell {
  packages = with pkgs; [
    git
    lilypond
    zsh
    locales
    stdenv.cc
    wxGTK32
    wxGTK32-media
    wxGTK32-webview
    mupdf
    cpanminus
    sudo
  ];

  shellHook = ''
    export LANG=en_US.UTF-8
    export LANGUAGE=en_US:en
    export LC_ALL=en_US.UTF-8

    # Install Perl modules like in the Dockerfile (CPAN names)
    cpanm --notest \
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

    # Alien::wxWidgets pinned release from Dockerfile
    cpanm --notest \
      https://github.com/sciurius/perl-Alien-wxWidgets/releases/download/R0.71/Alien-wxWidgets-0.71.tar.gz
  '';
}
