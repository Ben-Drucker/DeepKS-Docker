FROM benndrucker/deepks-core-depends:latest
RUN set -e

RUN apt-get update && apt-get install -y gfortran

COPY supporting_scripts/install-R-script.sh install-R-script.sh

RUN chmod +x install-R-script.sh && ./install-R-script.sh

COPY supporting_scripts/install-R-packages.R install-R-packages.R

RUN sed -r -i 's/suppressMessages\(bspm::enable\(\)\)/options(bspm.sudo = TRUE) \; suppressMessages(bspm::enable())/g' /etc/R/Rprofile.site
RUN printf "LC_CTYPE=C.utf8\nLC_COLLATE=C.utf8\nLC_TIME=C.utf8\nLC_MESSAGES=C.utf8\nLC_MONETARY=C.utf8\nLC_PAPER=C.utf8\nLC_MEASUREMENT=C.utf8\n" >> /home/dockeruser/.Renviron

# RUN Rscript install-R-packages.R



# docker build -t benndrucker/deepks-r --progress plain .

# docker buildx build --platform linux/amd64,linux/arm64 -t benndrucker/deepks-r:latest -t benndrucker/deepks-r:0.0.0 .

CMD /bin/zsh