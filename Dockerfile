FROM jupyter/scipy-notebook:python-3.9

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root

RUN apt-get update && apt-get full-upgrade -y && \
    # apt-get install --no-install-recommends -y && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*

USER ${NB_UID}

RUN mamba update -y -n base --all && \
    mamba install -y \
      plotly \
      jupyterlab-git && \
    mamba install -y -c conda-forge \
      ydata-profiling \
      theme-material-darcula \
      jupyterlab_vim && \
    mamba install -y -c pytorch \
      pytorch \
      cpuonly && \
    mamba install -y -c huggingface \
      transformers && \
    mamba clean --all -f -y

RUN pip3 install --no-cache-dir \
    polars

WORKDIR "${HOME}"
