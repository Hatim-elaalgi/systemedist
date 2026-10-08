# TP1 Python – partie 1 (uv + Docker)

Notebook d'exercices Python (`TP1python_partie1.ipynb`) exécuté dans un environnement
conteneurisé. Le Dockerfile reprend les étapes du guide `instalation_de_python_et_uv.pdf`
(uv, `uv venv`, ipykernel, pandas, matplotlib, seaborn), mais le `.venv` vit dans l'image
Docker au lieu d'être sur la machine.

## Prérequis

- Docker Desktop
- VS Code avec les extensions Python et Jupyter

## Travailler dans VS Code avec le kernel Docker

```bash
docker compose up -d lab
```

Dans le notebook : **Select Kernel → Select Another Kernel… → Existing Jupyter Server…**,
saisir `http://localhost:8888/?token=uv-docker`, puis choisir **Python (uv-env)**.

Arrêter le serveur : `docker compose down`.

## Exécuter tout le notebook sans interface

```bash
docker compose run --rm notebook
```

Le notebook exécuté est écrit dans `output/`. Les cellules qui utilisent `input()` doivent
être lancées depuis VS Code (ou Jupyter Lab sur http://localhost:8888).
