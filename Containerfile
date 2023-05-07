FROM ubuntu:22.04

RUN apt-get update \
    && apt-get upgrade \
    && apt-get install -y wget unzip make

RUN apt-get install -y texlive-latex-base texlive-fonts-recommended

RUN wget http://mirror.ctan.org/install/macros/latex/contrib/koma-script.tds.zip \
    && wget http://mirror.ctan.org/install/macros/latex/contrib/csquotes.tds.zip \
    && wget http://mirror.ctan.org/install/macros/latex/contrib/etoolbox.tds.zip \
    && wget http://mirror.ctan.org/install/macros/latex/contrib/enumitem.tds.zip \
    && unzip koma-script.tds.zip -d /usr/local/share/texmf/ \
    && unzip csquotes.tds.zip -d /usr/local/share/texmf/ \
    && unzip etoolbox.tds.zip -d /usr/local/share/texmf/ \
    && unzip enumitem.tds.zip -d /usr/local/share/texmf/ \
    && rm koma-script.tds.zip csquotes.tds.zip etoolbox.tds.zip enumitem.tds.zip \
    && texhash

