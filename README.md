# CloudMarkdown

![](https://github.com/shosatojp/cloudmd/workflows/Docker%20Image%20CI/badge.svg)

https://cloudmd.monoid.app/

## Features
* Compile Markdown to PDF (md -> tex -> pdf)
* Compile raw Tex

## Default Tex Packages
* booktabs
* longtable
* framed
* amsmath
* caption
* hyperref
* graphicx
* fancyvrb
* here
* multirow


## Common Use Case
1. Maintain your report directories with git.
1. Use CloudMd only when you compile.

## How to Build (for Developers)
```sh
make
```

## CLI Tool
* https://github.com/shosatojp/cloudmd-cli/

## Dependencies
* https://github.com/shosatojp/cloudmd-front/
* https://github.com/shosatojp/cloudmd-back/
* https://github.com/shosatojp/cloudmd-filter/


```
wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
tar xfv 
cd 
apt install perl
./install-tl
```