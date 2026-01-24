FROM octopusdeploy/worker-tools:6.5.0-ubuntu.22.04

# Set environment variables for nvm
ENV NVM_DIR=/usr/local/nvm
ENV NODE_VERSION=20

# Install nvm and Node.js, then find the actual installed version path
RUN mkdir -p $NVM_DIR \
    && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default \
    && ln -s $(dirname $(which node)) /usr/local/node

# Add node to PATH via symlink
ENV PATH=/usr/local/node:$PATH

# Install firebase-tools globally
RUN . $NVM_DIR/nvm.sh && npm install -g firebase-tools

# Verify installations
RUN node --version && npm --version && firebase --version
