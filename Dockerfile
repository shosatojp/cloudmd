FROM ubuntu:18.04
# install packages
RUN apt-get update && apt-get install -y \
    pandoc \
    sudo \
    wget \
    curl \
    git \
    texlive-lang-japanese \
    python3.8 \
    python3-pip
RUN curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - && \
    sudo apt-get install -y nodejs

# system settings
RUN adduser --disabled-password --gecos "" cloudmd

# tex settings
RUN kanji-config-updmap ipaex --sys
RUN echo "VARTEXFONTS=/tmp/texfonts" > /etc/texmf/texmf.d/00debian.cnf
RUN echo "shell_escape = p" >> /etc/texmf/texmf.d/00debian.cnf
RUN echo "shell_escape_commands = bibtex,bibtex8,extractbb,kpsewhich,makeindex,repstopdf" >> /etc/texmf/texmf.d/00debian.cnf
RUN echo "openout_any = p" >> /etc/texmf/texmf.d/00debian.cnf
RUN echo "openin_any = p" >> /etc/texmf/texmf.d/00debian.cnf
RUN update-texmf

# RUN apt-get install -y xzdec perl
# RUN tlmgr init-usertree
# RUN tlmgr option repository ftp://tug.org/historic/systems/texlive/2017/tlnet-final
# RUN tlmgr install here
# RUN tlmgr install booktabs
# RUN tlmgr install framed
# RUN tlmgr install caption
# RUN tlmgr install multirow
# RUN tlmgr install fancyvrb

RUN mkdir -p /usr/share/texlive/texmf-dist/tex/latex/tools/
RUN cd /home/cloudmd && wget http://mirrors.ctan.org/macros/latex/contrib/framed/framed.sty && \
    mv framed.sty /usr/share/texlive/texmf-dist/tex/latex/tools/
RUN cd /home/cloudmd && wget http://mirrors.ctan.org/macros/latex/contrib/booktabs/booktabs.dtx
RUN cd /home/cloudmd && wget http://mirrors.ctan.org/macros/latex/contrib/booktabs/booktabs.ins
RUN cd /home/cloudmd && latex booktabs.ins
RUN cd /home/cloudmd && mv *.sty /usr/share/texlive/texmf-dist/tex/latex/tools/
RUN cd /home/cloudmd && rm booktabs.dtx booktabs.ins booktabs.log
RUN cd /home/cloudmd && wget http://mirrors.ctan.org/macros/latex/contrib/caption.zip && \
    unzip caption.zip && cd caption && latex caption.ins && \
    mv *.sty /usr/share/texlive/texmf-dist/tex/latex/tools/
RUN cd /home/cloudmd && wget http://mirrors.ctan.org/macros/latex/contrib/multirow.zip && \
    unzip multirow.zip && cd multirow && latex multirow.ins && \
    mv *.sty /usr/share/texlive/texmf-dist/tex/latex/tools/
RUN cd /home/cloudmd && \
    wget http://mirrors.ctan.org/macros/latex/contrib/fancyvrb/latex/fancyvrb.sty && \
    wget http://mirrors.ctan.org/macros/latex/contrib/fancyvrb/latex/fancyvrb-ex.sty && \
    wget http://mirrors.ctan.org/macros/latex/contrib/fancyvrb/latex/hbaw.sty && \
    wget http://mirrors.ctan.org/macros/latex/contrib/fancyvrb/latex/hcolor.sty && \
    wget http://mirrors.ctan.org/macros/latex/contrib/here/here.sty && \
    mv *.sty /usr/share/texlive/texmf-dist/tex/latex/tools/
RUN cd /home/cloudmd && \
    wget http://mirrors.ctan.org/macros/latex/contrib/breqn.zip && \
    unzip breqn.zip && cd breqn && latex breqnbundle.ins && \
    mv *.sty /usr/share/texlive/texmf-dist/tex/latex/tools/
# RUN cd /home/cloudmd && wget http://mirrors.ctan.org/macros/latex/contrib/l3kernel.zip && \
#     unzip l3kernel.zip && cd l3kernel && for i in *.ins;do latex $i;done && \
#     mv * /usr/share/texlive/texmf-dist/tex/latex/tools/
# RUN cd /home/cloudmd && wget http://mirrors.ctan.org/macros/latex/contrib/l3packages.zip && \
#     unzip l3packages.zip && cd l3packages && for i in *.ins;do latex $i;done && \
#     mv * /usr/share/texlive/texmf-dist/tex/latex/tools/
# RUN cd /home/cloudmd && wget http://mirrors.ctan.org/macros/latex/contrib/l3experimental.zip && \
#     unzip l3experimental.zip && cd l3experimental && for i in *.ins;do latex $i;done && \
#     mv * /usr/share/texlive/texmf-dist/tex/latex/tools/

RUN mktexlsr

# clone projects
USER cloudmd
# ADD https://www.random.org/cgi-bin/randbyte?nbytes=10&format=h skipcache

RUN cd /home/cloudmd && git clone https://github.com/shosatojp/cloudmd-filter.git
RUN cd /home/cloudmd/cloudmd-filter && python3 -m pip install -r requirements.txt

RUN cd /home/cloudmd && git clone https://github.com/shosatojp/cloudmd-front.git
RUN cd /home/cloudmd/cloudmd-front && export NG_CLI_ANALYTICS=ci && npm i && ./node_modules/.bin/ng build --prod && npm run pdfjs

RUN cd /home/cloudmd && git clone https://github.com/shosatojp/cloudmd-back.git
RUN cd /home/cloudmd/cloudmd-back && export NG_CLI_ANALYTICS=ci && npm i
RUN cd /home/cloudmd/cloudmd-back && \
    wget https://github.com/lierdakil/pandoc-crossref/releases/download/v0.3.4.1a/linux-pandoc_2_7_3.tar.gz && \
    tar xfv linux-pandoc_2_7_3.tar.gz
RUN cd /home/cloudmd/cloudmd-back && npm run build

CMD node /home/cloudmd/cloudmd-back/app/src/app.js
EXPOSE 8080
