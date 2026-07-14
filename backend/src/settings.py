# src/settings.py

from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    APP_NAME: str = "Toy Deployment App"

    ENVIRONMENT: str = "development"

    DATABASE_URL: str = "sqlite:///./tasks.db"

    API_HOST: str = "127.0.0.1"
    API_PORT: int = 8003

    LOG_LEVEL: str = "INFO"

    CORS_ORIGINS: str = "http://localhost:3002"

    model_config = SettingsConfigDict(env_file=".env", extra="ignore")


settings = Settings()
