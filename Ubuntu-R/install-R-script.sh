#!/bin/zsh
set -e
# update indices
apt-get update -y  -qq
# install two helper packages we need
apt-get install -y --no-install-recommends software-properties-common dirmngr
# add the signing key (by Michael Rutter) for these repos
# To verify key, run gpg --show-keys /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc 
# Fingerprint: E298A3A825C0D65DFD57CBB651716619E084DAB9
wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
# add the R 4.0 repo from CRAN -- adjust 'focal' to 'groovy' or 'bionic' as needed
add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"

apt-get install -y --no-install-recommends r-base

add-apt-repository -r "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"

apt update -qq && apt install --yes --no-install-recommends wget \
    ca-certificates gnupg
wget -q -O- https://eddelbuettel.github.io/r2u/assets/dirk_eddelbuettel_key.asc \
    | tee -a /etc/apt/trusted.gpg.d/cranapt_key.asc

echo "deb [arch=amd64,arm64] https://r2u.stat.illinois.edu/ubuntu jammy main" \
     > /etc/apt/sources.list.d/cranapt.list
apt update -qq

echo "Package: *" > /etc/apt/preferences.d/99cranapt
echo "Pin: release o=CRAN-Apt Project" >> /etc/apt/preferences.d/99cranapt
echo "Pin: release l=CRAN-Apt Packages" >> /etc/apt/preferences.d/99cranapt
echo "Pin-Priority: 700"  >> /etc/apt/preferences.d/99cranapt

apt install --yes --no-install-recommends python3-{dbus,gi,apt}
## Then install bspm (as root) and enable it, and enable a speed optimization
Rscript -e 'install.packages("bspm")'
RHOME=$(R RHOME)
echo "suppressMessages(bspm::enable())" >> ${RHOME}/etc/Rprofile.site
echo "options(bspm.version.check=FALSE)" >> ${RHOME}/etc/Rprofile.site

