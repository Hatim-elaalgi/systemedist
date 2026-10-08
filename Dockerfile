# Containerised version of "Guide Complet : Python, uv, VS Code & Jupyter Notebook".
# The .venv the guide asks for lives inside the image instead of on the host.
FROM ghcr.io/astral-sh/uv:bookworm-slim

# Let uv download and manage Python itself, as in the guide
ENV UV_PYTHON_INSTALL_DIR=/opt/python \
    UV_LINK_MODE=copy \
    UV_COMPILE_BYTECODE=1 \
    MPLBACKEND=Agg

WORKDIR /app

# Steps 2 & 4 of the guide: project files (uv init + uv add) -> uv venv -> install locked deps
COPY pyproject.toml uv.lock ./
RUN uv venv && uv sync --locked --no-install-project

# Step 3 of the guide: "activate" the venv for every command in the container
ENV VIRTUAL_ENV=/app/.venv \
    PATH="/app/.venv/bin:$PATH"

# Hidden step of the guide: register the kernel under the same name
RUN python -m ipykernel install --sys-prefix --name=python_uv_workspace --display-name "Python (uv-env)"

COPY TP1python_partie1.ipynb ./

# Default: execute the notebook headless and write the result to /app/output
CMD ["sh", "-c", "mkdir -p output && jupyter nbconvert --to notebook --execute --allow-errors --ExecutePreprocessor.kernel_name=python_uv_workspace --output-dir output TP1python_partie1.ipynb"]
