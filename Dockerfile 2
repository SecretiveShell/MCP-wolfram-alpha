FROM python:3.12-slim-bullseye

RUN pip install uv

COPY . .

RUN uv venv --python 3.12
RUN uv sync

ENTRYPOINT [ "uv", "run", "mcp-wolfram-alpha" ]