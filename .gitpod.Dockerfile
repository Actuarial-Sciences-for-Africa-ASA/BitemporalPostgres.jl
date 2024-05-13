FROM gitpod/workspace-postgres
# Install direnv
RUN sudo mkdir ~/julia && wget $JULIA_DOWNLOAD_URL | tar -xvf -C ~/julia \
  && apt-get update && sudo apt-get install -y direnv \
  && direnv hook bash >> /home/gitpod/.bashrc 
