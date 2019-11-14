FROM ubuntu:18.04
# install packages
RUN apt-get update && apt-get install -y \
    pandoc \
    sudo \
    wget \
    curl \
    git \
    texlive-lang-japanese
RUN curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - && \
    sudo apt-get install -y nodejs

# system settings
RUN adduser --disabled-password --gecos "" cloudmd

# tex settings
RUN kanji-config-updmap ipaex --sys
RUN echo "VARTEXFONTS=/tmp/texfonts \\
    shell_escape = p \\
    shell_escape_commands = bibtex,bibtex8,extractbb,kpsewhich,makeindex,repstopdf \\
    openout_any = p \\
    openin_any = p" > /etc/texmf/texmf.d/00debian.cnf && update-texmf
RUN mkdir -p /usr/share/texlive/texmf-dist/tex/latex/tools/
RUN cd /home/cloudmd && wget http://mirrors.ctan.org/macros/latex/contrib/framed/framed.sty && \
    mv framed.sty /usr/share/texlive/texmf-dist/tex/latex/tools/
RUN cd /home/cloudmd && wget http://mirrors.ctan.org/macros/latex/contrib/booktabs/booktabs.dtx
RUN cd /home/cloudmd && wget http://mirrors.ctan.org/macros/latex/contrib/booktabs/booktabs.ins
RUN cd /home/cloudmd && latex booktabs.ins
RUN cd /home/cloudmd && mv *.sty /usr/share/texlive/texmf-dist/tex/latex/tools/
RUN cd /home/cloudmd && rm booktabs.dtx booktabs.ins booktabs.log
RUN mktexlsr

# clone projects
RUN su - cloudmd
RUN cd /home/cloudmd && git clone "https://github.com/shosatojp/cloudmd-front.git"
RUN cd /home/cloudmd/cloudmd-front && export NG_CLI_ANALYTICS=ci && npm i && ./node_modules/.bin/ng build
RUN cd /home/cloudmd && git clone https://github.com/shosatojp/cloudmd-back.git
RUN cd /home/cloudmd/cloudmd-back && export NG_CLI_ANALYTICS=ci && npm i
EXPOSE 8084
# CMD while true; do sleep 1000; done
CMD cd /home/cloudmd/cloudmd-back && npm run server