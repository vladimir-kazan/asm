# docker build --no-cache -t nasm -f dockerfiles/Dockerfile .
# docker run --rm -it --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -v $(pwd)/src:/root/src nasm

FROM ubuntu:16.04

RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get -y install git nasm gdb vim libtool && \
  rm -rf /var/lib/apt/lists/*

# Add files.
ADD root/.gdbinit /root/.gdbinit


# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

# Define default command.
CMD ["bash"]