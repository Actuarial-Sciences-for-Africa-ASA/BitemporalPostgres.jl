FROM gitpod/workspace-postgres
# Install direnv
RUN sudo apt-get update && sudo apt-get install -y direnv \
  && direnv hook bash >> /home/gitpod/.bashrc \
  && curl -L https://storage.googleapis.com/julialang2/bin/linux/x64/$JULIA_MINOR_VERSION/julia-$JULIA_BUGFIX_VERSION-linux-x86_64.tar.gz | tar -C ~ -xpz \
  && echo $JULIA_MINOR_VERSION > /home/gitpod/bubu.txt
