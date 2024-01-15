FROM ubuntu:22.04

ARG TL_YEAR=2022

COPY texlive.profile /tmp/

ENV PATH="/usr/local/texlive/${TL_YEAR}/bin/x86_64-linux:$PATH"
ENV XDG_TEMPLATES_DIR="/templates"

# Install some needed packages.
RUN apt-get update \
    && apt-get install -y \
        cmake \
        graphviz \
        make \
        pandoc \
        perl \
        plantuml \
        tar \
        wget \
    && apt-get clean \
    && rm -Rf /var/lib/apt/lists/* \
    && rm -Rf /usr/share/doc && rm -Rf /usr/share/man

# Install lexlive from tug.org.
RUN wget ftp://tug.org/historic/systems/texlive/${TL_YEAR}/tlnet-final/install-tl-unx.tar.gz \
    && mkdir /tmp/install-tl \
    && tar -xzf install-tl-unx.tar.gz -C /tmp/install-tl --strip-components=1 \
    && /tmp/install-tl/install-tl \
        --profile=/tmp/texlive.profile \
        --repository=ftp://tug.org/historic/systems/texlive/${TL_YEAR}/tlnet-final \
# Install some needed tex packages.
    && tlmgr update --self \
    && tlmgr install \
        babel-german \
        biber \
        biblatex \
        booktabs \
        collection-fontsrecommended \
        collection-latex \
        csquotes \
        enumitem \
        etoolbox \
        koma-script \
        lastpage \
# mdwtools for example needed for footnote.sty
        mdwtools \
        paralist \
        setspace \
# Clean up a little bit
    && rm -r /install-tl-unx.tar.gz /tmp/*

VOLUME [ "/workdir", "${XDG_TEMPLATES_DIR}" ]
WORKDIR /workdir

