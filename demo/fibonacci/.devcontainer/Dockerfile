FROM ubuntu:20.04

# Installing as root: docker images are usually set up as root.
# Since some autotools scripts might complain about this being unsafe, we set
# FORCE_UNSAFE_CONFIGURE=1 to avoid configure errors.
ENV FORCE_UNSAFE_CONFIGURE=1
ENV DEBIAN_FRONTEND noninteractive

ENV TZ=Europe/Paris
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y \
  sudo \
  bash \
  cpio \
  wget \
  vim \
  emacs \
  emacs-goodies-el \
  tmux \
  curl \
  patch \
  unzip \
  bzip2 \
  mlocate \
  gawk \
  bison \
  flex \
  jq \
  git \
  subversion \
  mercurial \
  build-essential \
  gfortran \
  clang \
  clang-tidy \
  autoconf \
  automake \
  cmake \
  cmake-data\
  cmake-curses-gui \
  gcc \
  g++ \
  graphviz \
  doxygen \
  texinfo \
  texlive \
  texlive-latex-extra\
  texlive-lang-french\
  pkg-config \
  environment-modules \
  gcovr \
  lcov \
  cppcheck \
  libcppunit-dev \
  libgtest-dev \
  vera++ \
  valgrind \
  python3 \
  python3-pip \
  pylint \
  julia \
  libjulia-dev \
  openjdk-8-jdk && \
  apt-get autoremove -y

RUN cd /usr/src/gtest && \
    cmake . && \
    make && \
    mv lib/libg* /usr/lib/

RUN pip3 install --upgrade pip && \
    python3 -m pip install pytest pytest-cov coverage scan-build setuptools lcov_cobertura && \
    python3 -m pip install numpy scipy scikit-learn matplotlib pandas ipython

RUN update-alternatives --install /usr/bin/python python /usr/bin/python2.7 1 && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3.8 2

RUN groupadd -f -g 1000 gitlab && \
    useradd -u 1000 -g gitlab -ms /bin/bash gitlab && \
    mkdir /builds && \
    chown -R gitlab:gitlab /builds && \
    echo "gitlab:gitlab" | chpasswd && adduser gitlab sudo

# Install git-archive-all to get submodules when using git archive
RUN mkdir -p /home/gitlab/sonar && \
    cd /home/gitlab/sonar/ && \
    git clone https://github.com/Kentzo/git-archive-all.git && \
    cp /home/gitlab/sonar/git-archive-all/git_archive_all.py /home/gitlab/sonar/git-archive-all/git-archive-all && \
    chmod +x /home/gitlab/sonar/git-archive-all/git-archive-all && \
    ln -s /home/gitlab/sonar/git-archive-all/git-archive-all /usr/local/bin/git-archive-all

ENV version_rats 2.4
RUN cd /home/gitlab/sonar/ && \
    wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/rough-auditing-tool-for-security/rats-${version_rats}.tgz && \
    tar -xzvf rats-${version_rats}.tgz && \
    cd rats-${version_rats} && \
    ./configure && make && sudo make install && \
    rm /home/gitlab/sonar/rats-2.4.tgz

ENV version_drmemory 2.3.0-1
RUN cd /home/gitlab/sonar && \
    wget https://github.com/DynamoRIO/drmemory/releases/download/release_2.3.0/DrMemory-Linux-${version_drmemory}.tar.gz && \
    tar xf DrMemory-Linux-${version_drmemory}.tar.gz

RUN cd /home/gitlab/sonar && \
    wget --no-check-certificate https://scan.coverity.com/download/linux64 --post-data "token=TPvx1_FxIoOMK3-4GnuAlg&project=Chameleon" -O coverity_tool.tgz && \
    tar xf coverity_tool.tgz && \
    ln -s -f $PWD/cov-analysis-linux64-*/bin/cov-build /usr/local/bin/cov-build && \
    rm /home/gitlab/sonar/coverity_tool.tgz

RUN cd /home/gitlab/sonar && \
    git clone https://github.com/SonarOpenCommunity/sonar-cxx.git && \
    chmod +x /home/gitlab/sonar/sonar-cxx/cxx-sensors/src/tools/vera++Report2checkstyleReport.perl && \
    ln -s /home/gitlab/sonar/sonar-cxx/cxx-sensors/src/tools/vera++Report2checkstyleReport.perl /usr/local/bin/vera++Report2checkstyleReport.perl

RUN cd /home/gitlab/sonar && \
    wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.4.0.2170-linux.zip && \
    unzip sonar-scanner-cli-4.4.0.2170-linux.zip && \
    ln -s /home/gitlab/sonar/sonar-scanner-4.4.0.2170-linux/bin/sonar-scanner /usr/local/bin/sonar-scanner && \
    rm /home/gitlab/sonar/sonar-scanner-cli-4.4.0.2170-linux.zip

RUN usermod -aG sudo gitlab
RUN chown -R gitlab:gitlab /home/gitlab/
USER gitlab

# change the default shell to be bash
SHELL ["/bin/bash", "-c"]

# set DRMEMORY path (does not work without using an absolute path)
ENV DRMEMORY /home/gitlab/sonar/DrMemory-Linux-${version_drmemory}/bin64

# default working directory is
WORKDIR /builds
