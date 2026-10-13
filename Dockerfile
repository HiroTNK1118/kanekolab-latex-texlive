#----------
# install base image (ghcr.io/hirotnk1118/kanekolab-latex-base)
#----------
FROM ghcr.io/hirotnk1118/kanekolab-latex-base:26.2.0

ENV DEBIAN_FRONTEND=noninteractive
ENV DEBCONF_NOWARNINGS=yes
ENV PATH="/usr/local/texlive/bin:$PATH"
ENV LC_ALL=C


#----------
# install TeX Live 2026 and packages
#----------
ARG TEXLIVE_VERSION=2026
ARG TEXLIVE_MIRROR="https://mirror.ctan.org/systems/texlive/tlnet"

# Use Bash to detect failures in pipelines.
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN set -euxo pipefail; \
    \
    # Install TeX Live
    mkdir -p /tmp/install-tl-unx; \
    curl -fsSL "${TEXLIVE_MIRROR}/install-tl-unx.tar.gz" \
        | tar -xz -C /tmp/install-tl-unx --strip-components=1; \
    printf '%s\n' \
        'selected_scheme scheme-basic' \
        'tlpdbopt_install_docfiles 0' \
        'tlpdbopt_install_srcfiles 0' \
        > /tmp/install-tl-unx/texlive.profile; \
    /tmp/install-tl-unx/install-tl \
        --repository "${TEXLIVE_MIRROR}" \
        -profile /tmp/install-tl-unx/texlive.profile; \
    rm -rf /tmp/install-tl-unx; \
    ln -sfn \
        "/usr/local/texlive/${TEXLIVE_VERSION}/bin/$(uname -m)-linux" \
        /usr/local/texlive/bin; \
    \
    # Install TeX Live packages without documentation and source files
    tlmgr option docfiles 0; \
    tlmgr option srcfiles 0; \
    tlmgr install \
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
        latexindent; \
    \
    # Remove any remaining documentation and source files
    rm -rf \
        "/usr/local/texlive/${TEXLIVE_VERSION}/texmf-dist/doc" \
        "/usr/local/texlive/${TEXLIVE_VERSION}/texmf-dist/source"; \
    mktexlsr; \
    \
    # Install create_font_cache.sh and generate font cache
    curl -fsSL \
        -o /tmp/create_font_cache.sh \
        https://raw.githubusercontent.com/HiroTNK1118/kanekolab-latex-texlive/main/create_font_cache.sh; \
    chmod +x /tmp/create_font_cache.sh; \
    /tmp/create_font_cache.sh; \
    rm -f /tmp/create_font_cache.sh; \
    \
    # Add user "latex" and prepare working directory
    useradd -m -s /bin/bash latex; \
    mkdir -p /workdir; \
    chown latex:latex /workdir


#----------
# set user and working directory
#----------
USER latex
WORKDIR /workdir
