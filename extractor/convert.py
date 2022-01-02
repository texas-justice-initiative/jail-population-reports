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
import pendulum

# replace with config object that loads doc config info in extractor /config directory
DOC_CONFIG: dict = {
    "jail_population": {
        "start_row": 6,
        "null_threshold": 10,
        "include_final_row": False,
        "has_totals": True,
    },
    "immigration": {
        "start_row": 0,
        "null_threshold": False,
        "include_final_row": True,
        "has_totals": True,
    },
    "pregnancies": {
        "start_row": 0,
        "null_threshold": False,
        "include_final_row": True,
        "has_totals": True,
    },
}


class PDFConverter:
    """Turn PDF into CSV file"""

    def __init__(
        self, document_type: str, data_path: Path, doc_config: dict = DOC_CONFIG
    ):
        self.doc_type: str = document_type
        self.doc_path: Path = data_path
        self.data: list = []
        self.pages: Optional[TableList] = None
        self.page_count: Optional[int] = None
        self._config: Dict = doc_config[self.doc_type]
        self._processed_at = pendulum.now("UTC")
        self._data_date = f"{self.doc_path.parts[1]}{self.doc_path.parts[2].zfill(2)}"

    def _read(self):
        self.pages = camelot.read_pdf(
            self.doc_path.as_posix(), flavor="stream", pages="all"
        )
        self.page_count = self.pages.n

    def _process_page(self, page: Table):
        data = page.df[self._config["start_row"] :]
        data.replace("", np.nan, inplace=True)
        if not self._config["null_threshold"]:
            data.dropna(thresh=self._config["null_threshold"], inplace=True)
        data["processed_at"] = self._processed_at
        data["report_date"] = self._data_date
        return data

    def _process(self) -> Tuple:
        data: list = []
        metrics: dict = {}
        try:
            self._read()
        except FileNotFoundError:
            raise FileNotFoundError("Incorrect input file path")

        if self.pages is not None:
            for idx, page in enumerate(self.pages):
                data.append(self._process_page(page))
                parse_report: pd.DataFrame = page.parsing_report
                parse_report["processed_at"] = self._processed_at
                parse_report["report_date"] = self._data_date
                metrics.update({idx: parse_report})
        return pd.concat(data), pd.DataFrame(metrics).T

    def _export(self, data: pd.DataFrame, output_type: str) -> None:
        data.to_csv(self.doc_path.parent / f"{output_type}.csv", index=False)

    def convert(self) -> None:
        raw_data, metrics = self._process()
        self._export(raw_data, "raw")
        self._export(metrics, "metrics")
