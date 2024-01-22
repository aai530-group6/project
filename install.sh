#!/usr/bin/env bash

# UPDATE PACKAGE LISTS
sudo apt-get update --yes -qq

# --------------------------------------------------------------------------- #
# SETUP LATEX
# --------------------------------------------------------------------------- #
sudo apt-get install --no-install-recommends --yes -qq \
    chktex

# INSTALL TINYTEX
wget -qO- "https://yihui.org/tinytex/install-bin-unix.sh" | sh >/dev/null

# FIND TINYTEX BIN DIRECTORY
TINYTEX_DIR="$(kpsewhich -var-value=SELFAUTOPARENT)"
BIN_DIR="$TINYTEX_DIR/bin"
if [ -d "$BIN_DIR" ]; then
    echo "TinyTeX bin directory found: $BIN_DIR"
else
    echo "TinyTeX bin directory not found. Installation may have failed."
    exit 1
fi

# CHECK IF TINYTEX IS ALREADY IN PATH
if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
    # ADD TINYTEX TO PATH IN .bashrc
    echo "export PATH=\"\$PATH:$BIN_DIR\"" >>~/.bashrc
    echo "TinyTeX bin directory added to PATH."
    # shellcheck source=/dev/null
    source ~/.bashrc >/dev/null
else
    echo "TinyTeX bin directory already in PATH."
fi

# INSTALL PACKAGES
tlmgr install \
    adjustbox \
    algorithms \
    biber \
    biblatex \
    biblatex-apa \
    bookmark \
    breqn \
    caption \
    chktex \
    enumitem \
    extsizes \
    fira \
    fontaxes \
    latexindent \
    lipsum \
    latexmk \
    microtype \
    multirow \
    ncntrsbk \
    pdfpages \
    pdflscape \
    pgfgantt \
    setspace \
    synctex \
    texcount

# UPDATE TEXLIVE MANAGER
tlmgr update --self --all
updmap
texhash
tlmgr path add

# rm -rf /usr/bin/biber
# rm -rf /bin/biber

echo "TinyTeX installed to $TINYTEX_DIR"
