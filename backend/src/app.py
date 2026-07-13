from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from src.settings import settings
from src.server import router

from logger import get_logger


logger = get_logger(__name__)


# ==================================================
# FastAPI App
# ==================================================

app = FastAPI(
    title=settings.APP_NAME,
    version="1.0.0",
)


# ==================================================
# CORS
# ==================================================

app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.CORS_ORIGINS,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

logger.info("CORS middleware configured")


# ==================================================
# Startup
# ==================================================

@app.on_event("startup")
async def startup_event():

    logger.info(
        f"{settings.APP_NAME} started "
        f"in {settings.ENVIRONMENT} mode"
    )


# ==================================================
# Routers
# ==================================================

app.include_router(router)
