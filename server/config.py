from pydantic import BaseSettings, PostgresDsn


class Settings(BaseSettings):
    """
    Settings class for the shop app.
    """
    root_address: str = "http://127.0.0.1:8000"
    # redis: RedisDsn = "redis://localhost:6379/0?decode_responses=True"
    # skip_email_verification: bool = False
    db_url: str | PostgresDsn = "sqlite:///sd_replacement.db"
    # hcaptcha_key: str
    # mail_address: str
    # mail_password: str
    # mail_username: str
    # mail_server: str
    # mail_port: int
    secret_key: str = "secret_key"
    # access_token_expire_minutes: int = 30
    # cache_expiry: int = 86400

    class Config:
        env_file = ".env"
        env_file_encoding = 'utf-8'


settings = Settings()
