FROM ubuntu:22.04

ARG TL_YEAR=2022

COPY texlive.profile /tmp/

ENV PATH=/usr/local/texlive/2022/bin/x86_64-linux:$PATH

RUN apt-get update \
# Install some needed packages.
    && apt-get install -y \
        make \
        pandoc \
        perl \
        tar \
        wget \
# Install lexlive from tug.org.
    && wget ftp://tug.org/historic/systems/texlive/${TL_YEAR}/tlnet-final/install-tl-unx.tar.gz \
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
        collection-fontsrecommended \
        collection-latex \
        csquotes \
        enumitem \
        etoolbox \
        koma-script \
        lastpage \
        paralist
