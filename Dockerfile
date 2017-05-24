FROM yueyehua/centos-base
MAINTAINER Richard Delaplace "rdelaplace@yueyehua.net"
LABEL version="1.0.0"

ENV _RUBY_VERSION=2.4.0

# Install dependencies
RUN \
  yum -y install git-all gcc gcc-c++ make openssl-devel libcurl-devel \
    readline-devel libffi-devel bzip2 sqlite3

# Clean all
RUN \
  yum clean all;

# Install rbenv
RUN \
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv && \
  git clone https://github.com/rbenv/ruby-build.git \
    ~/.rbenv/plugins/ruby-build;

# Install Ruby
RUN \
  /root/.rbenv/bin/rbenv install ${_RUBY_VERSION} && \
  /root/.rbenv/bin/rbenv global ${_RUBY_VERSION};

# Export PATH
ENV PATH=$PATH:/root/.rbenv/bin:/root/.rbenv/shims

# Check rbenv installation
RUN \
  curl -fsSL \
    https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | \
    bash

# Install few gems
RUN \
  /root/.rbenv/shims/gem install \
    -q --no-rdoc --no-ri --no-format-executable --no-user-install \
    rubocop yaml-lint bundler rspec;

VOLUME ["/sys/fs/cgroup"]
CMD  ["/lib/systemd/systemd"]
