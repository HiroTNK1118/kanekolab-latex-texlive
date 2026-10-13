#----------
# install base image (ghcr.io/hirotnk1118/kanekolab-latex-base)
#----------
FROM ghcr.io/hirotnk1118/kanekolab-latex-base:26.2.0

ENV DEBIAN_FRONTEND=noninteractive
ENV DEBCONF_NOWARNINGS=yes
ENV PATH="/usr/local/texlive/bin:$PATH"
ENV LC_ALL=C


#----------
# install TeX Live 2024
#----------
# define TeXLive version and CTAN mirror
ARG TEXLIVE_VERSION=2024
ARG TEXLIVE_MIRROR="https://mirror.ctan.org/systems/texlive/tlnet"
# install TeXLive from CTAN mirror
RUN mkdir /tmp/install-tl-unx && \
    curl -L ${TEXLIVE_MIRROR}/install-tl-unx.tar.gz | tar -xzv -C /tmp/install-tl-unx --strip-components=1 && \
    /bin/echo -e \
    'selected_scheme scheme-basic\ntlpdbopt_install_docfiles 0\ntlpdbopt_install_srcfiles 0' \
    > /tmp/install-tl-unx/texlive.profile && \
    /tmp/install-tl-unx/install-tl --repository ${TEXLIVE_MIRROR} -profile /tmp/install-tl-unx/texlive.profile && \
    rm -r /tmp/install-tl-unx && \
    ln -sf /usr/local/texlive/${TEXLIVE_VERSION}/bin/$(uname -m)-linux /usr/local/texlive/bin


#----------
# install TeX Live packages and others
#----------
RUN tlmgr install \
    collection-bibtexextra \
    collection-latexextra \
    collection-latexrecommended \
    collection-luatex \
    collection-langjapanese \
    collection-mathscience \
    collection-pictures \
    latexmk \
    latexdiff \
    stix2-otf \
    latexindent && \
    mktexlsr && \
    # install create_font_cache.sh
    curl -L -O https://raw.githubusercontent.com/being24/latex-docker/master/create_font_cache.sh && \
    chmod +x create_font_cache.sh && \
    ./create_font_cache.sh && \
    rm create_font_cache.sh && \
    # install tex-fmt
    curl -L -o tex-fmt.tar.gz https://github.com/WGUNDERWOOD/tex-fmt/releases/latest/download/tex-fmt-$(uname -m)-linux.tar.gz && \
    tar -xzvf tex-fmt.tar.gz && \
    mv tex-fmt /usr/local/bin && \
    rm tex-fmt.tar.gz && \
    # add user "latex" and set permissions
    useradd -m -s /bin/bash latex && \
    chown -R latex:latex /usr/local/texlive && \
    chmod u+w /usr/local/texlive


#----------
# set user and working directry
#----------
USER latex
WORKDIR /workdir
