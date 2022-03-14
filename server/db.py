import databases
import sqlalchemy

from server.config import settings

database = databases.Database(settings.db_url)
metadata = sqlalchemy.MetaData()
