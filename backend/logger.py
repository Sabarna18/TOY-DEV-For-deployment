# src/logger.py

import logging
from pathlib import Path

from src.settings import settings

# Create logs directory automatically
Path("logs").mkdir(exist_ok=True)

LOG_FILE = "logs/app.log"

logging.basicConfig(
    level=getattr(logging, settings.LOG_LEVEL),
    format=(
        "%(asctime)s | "
        "%(levelname)s | "
        "%(name)s | "
        "%(message)s"
    ),
    handlers=[
        logging.FileHandler(LOG_FILE),
        logging.StreamHandler()
    ]
)


def get_logger(name: str):
    return logging.getLogger(name)