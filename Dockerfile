FROM python:3.12-slim-bullseye

# Install uv
RUN pip install --no-cache-dir uv

# Set working directory
WORKDIR /app

# Copy project files (needed for package build)
COPY pyproject.toml uv.lock README.md ./
COPY src/ ./src/

# Create virtual environment and install dependencies
RUN uv venv --python 3.12
RUN uv sync --frozen

# Copy any remaining files
COPY . .

# Create a non-root user for security
RUN groupadd -r appuser && useradd -r -g appuser appuser \
    && mkdir -p /home/appuser/.cache \
    && chown -R appuser:appuser /app /home/appuser
USER appuser

# Set environment variables
ENV PATH="/app/.venv/bin:$PATH"

ENTRYPOINT [ "uv", "run", "mcp-wolfram-alpha" ]