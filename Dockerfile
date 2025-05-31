FROM docker.io/debian:bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    git ca-certificates build-essential curl \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN curl -sL -o /tmp/nvim.tar.gz https://github.com/neovim/neovim/releases/download/v0.11.2/nvim-linux-x86_64.tar.gz \
 && tar -xzf /tmp/nvim.tar.gz -C /tmp && mv /tmp/nvim-linux-x86_64 /opt/nvim && rm /tmp/nvim.tar.gz

RUN mkdir /root/.config && git clone https://github.com/influentcoder/nvim-config.git /root/.config/nvim
RUN /opt/nvim/bin/nvim --headless "+Lazy! sync" +qa && \
    /opt/nvim/bin/nvim --headless "+TSUpdateSync" +qa

# Add Neovim to PATH
ENV PATH="/opt/nvim/bin:$PATH"

# Use nvim as the entrypoint
ENTRYPOINT ["nvim"]
