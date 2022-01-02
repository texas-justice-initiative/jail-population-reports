"""Connect to and load CSV to external database"""
from pathlib import Path
import sqlalchemy as sa
import pandas as pd


class DatabaseConnection:
    def __init__(self, engine: sa.engine.Engine):
        self._db = engine

    def load(self, document_type: str, data_path: Path) -> None:
        """
        TODO: Rewrite using SQLAlchemy to handle dynamic column creation/dropping&recreating tables and config for table structures
        """
        for data_type in ["metrics", "raw"]:
            # load data csv to dataframe
            df = pd.read_csv(data_path / f"{data_type}.csv")

            # load data df to RDS db
            df.to_sql(
                name=f"{document_type}_{data_type}",
                con=self._db,
                if_exists="append",
                index=False,
            )
