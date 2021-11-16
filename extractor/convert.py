"""
TODO: 
- configure PDF parser (adjust size & also specify columns)
"""
from typing import Dict, Tuple, Optional
from pathlib import Path
import numpy as np
import camelot
from camelot.core import Table, TableList
import pandas as pd

# replace with config object that loads doc config info in extractor /config directory
DOC_CONFIG: dict = {
    "jail_population": {
        "start_row": 6,
        "null_threshold": 10,
        "include_final_row": False,
        "has_totals": True,
    }
}


class PDFConverter:
    """Turn PDF into CSV file"""

    def __init__(self, doc_type: str, doc_path: Path, doc_config: dict = DOC_CONFIG):
        self.doc_type: str = doc_type
        self.doc_path: Path = doc_path
        self.data: list = []
        self.pages: Optional[TableList] = None
        self.page_count: Optional[int] = None
        self._config: Dict = doc_config[self.doc_type]

    def _read(self):
        self.pages = camelot.read_pdf(
            self.doc_path.as_posix(), flavor="stream", pages="all"
        )
        self.page_count = self.pages.n

    def _process_page(self, page: Table):
        data = page.df[self._config["start_row"] :]
        data.replace("", np.nan, inplace=True)
        data.dropna(thresh=self._config["null_threshold"], inplace=True)
        return data

    def process(self) -> Tuple:
        data: list = []
        metrics: dict = {}
        try:
            self._read()
        except FileNotFoundError:
            raise FileNotFoundError("Incorrect input file path")

        if self.pages is not None:
            for idx, page in enumerate(self.pages):
                data.append(self._process_page(page))
                metrics.update({idx: page.parsing_report})
        return pd.concat(metrics), pd.DataFrame(metrics).T

    def export(self):
        pass
