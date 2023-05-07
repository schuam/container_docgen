FROM ubuntu:22.04

COPY texlive.profile /tmp/

ENV PATH=/usr/local/texlive/2022/bin/x86_64-linux:$PATH

RUN apt-get update \
    && apt-get upgrade \
    && apt-get install -y wget perl tar

RUN wget ftp://tug.org/historic/systems/texlive/2022/tlnet-final/install-tl-unx.tar.gz \
    && mkdir /tmp/install-tl \
    && tar -xzf install-tl-unx.tar.gz -C /tmp/install-tl --strip-components=1 \
    && /tmp/install-tl/install-tl \
        --profile=/tmp/texlive.profile \
        --repository=ftp://tug.org/historic/systems/texlive/2022/tlnet-final \
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
        lastpage
