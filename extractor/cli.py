import click
from pathlib import Path

from extractor.connection.tcjs import TCJSConnection

@click.command()
def extract():
    TCJSConnection.download('jail_population', '202109', Path('./data'))