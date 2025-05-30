FROM docker.io/curlimages/curl:8.13.0 AS downloader

# Download and extract Neovim archive
WORKDIR /tmp
RUN curl -LO https://github.com/neovim/neovim/releases/download/v0.11.1/nvim-linux-x86_64.tar.gz \
 && tar -xzf nvim-linux-x86_64.tar.gz

# Final image
FROM docker.io/debian:bookworm-slim

# Copy Neovim from the downloader stage
COPY --from=downloader /tmp/nvim-linux-x86_64 /opt/nvim

# Add Neovim to PATH
ENV PATH="/opt/nvim/bin:$PATH"

# Use nvim as the entrypoint
ENTRYPOINT ["nvim"]
