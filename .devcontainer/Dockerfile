FROM ghcr.io/rocker-org/devcontainer/tidyverse:4.4

RUN install2.r httpgd languageserver fixest skimr panelView tidyfinance tsibble fable nycflights13 \
    && rm -rf /tmp/downloaded_packages
