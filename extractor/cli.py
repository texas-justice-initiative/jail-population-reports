import click
from pathlib import Path
import os
import datetime

import dotenv
import sqlalchemy as sa
import pandas as pd

from extractor.tcjs import TCJSConnection
from extractor.convert import PDFConverter
from extractor.database import DatabaseConnection

dotenv.load_dotenv()
postgres_engine = sa.create_engine(
    f'postgresql+psycopg2://{os.getenv("DB_USERNAME")}:{os.getenv("DB_PASSWORD")}@{os.getenv("DB_URI")}:{os.getenv("DB_PORT")}/{os.getenv("DB_EXTERNAL")}'
)


@click.command()
@click.option(
    "--report-type",
    type=click.Choice(["jail_population", "pregnancies", "immigration"]),
)
@click.option("--download", is_flag=True)
@click.option("--convert", is_flag=True)
@click.option("--load", is_flag=True)
@click.option("--date-start", type=click.DateTime(formats=["%Y%m"]), default="202112")
@click.option("--date-end", type=click.DateTime(formats=["%Y%m"]), default="202201")
def extract(report_type, download, convert, load, date_start, date_end):
    reports: list = ["jail_population", "pregnancies", "immigration"]
    if report_type is not None:
        reports = [report_type]

    start: datetime.datetime = date_start.date()
    end: datetime.datetime = date_end.date()

    click.echo(f"Reports between {start} to {end}")
    for report_date in pd.date_range(
        start, end + datetime.timedelta(days=35), freq="m"
    ):
        report_year = report_date.year
        report_month = str(int(report_date.month))

        for report in reports:
            click.echo(f"Processing {report} | {report_year}{report_month}")
            if download:
                click.echo("Downloading PDF")
                TCJSConnection().download(
                    document_type=report,
                    data_year=report_year,
                    data_month=report_month,
                    data_path=Path("./data"),
                )

            if convert:
                click.echo("Converting PDF to CSV")
                PDFConverter(
                    document_type=report,
                    data_path=Path(
                        f"./data/{report_year}/{report_month}/{report}/raw.pdf"
                    ),
                ).convert()

            if load:
                click.echo("Loading CSV to data warehouse")
                DatabaseConnection(engine=postgres_engine).load(
                    data_path=Path(f"./data/{report_year}/{report_month}/{report}"),
                    document_type=report,
                )
