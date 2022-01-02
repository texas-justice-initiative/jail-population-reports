"""
Confirm converter extracts two CSVs: 
- Raw data from PDF
    - And characteristics on output PDF matches current config values (ie, page number, has total, start row, etc)
- Metrics on PDF conversion accuracy

TODO: Update to use new test assets (lock pendulum now)
"""
from pathlib import Path
import pandas as pd
import pendulum
import pytest
import os
from extractor.convert import DOC_CONFIG, PDFConverter


ASSET_PATH: Path = Path(__file__).parent.parent / "assets"


@pytest.fixture(autouse=True)
def parser(doc):
    """Fixture to set up before and clean up after a test is run"""
    # set up test scenario
    doc_type = doc[0]
    doc_date = pendulum.from_format(doc[1], "YYYYMM")
    doc_path: Path = ASSET_PATH / str(doc_date.year) / str(doc_date.month) / doc_type
    os.makedirs(doc_path, exist_ok=True)
    expected_data: pd.DataFrame = pd.read_csv(doc_path / f"raw.csv")
    expected_metrics: pd.DataFrame = pd.read_csv(doc_path / "metrics.csv")

    _parser: PDFConverter = PDFConverter(
        document_type=doc_type, data_path=doc_path / f"raw.pdf"
    )
    actual_data, actual_metrics = _parser._process()

    # output artifacts to be tested
    yield _parser, actual_data, actual_metrics, expected_data, expected_metrics


@pytest.mark.parametrize(
    "doc",
    [
        ("jail_population", "202109", 9)
    ],  # dataset name, document date, number of pages in sample doc
)
def test_converter(parser, doc):
    # TODO: add/confirm correct created_at
    static_now = pendulum.datetime(2022, 1, 1, 12)
    with pendulum.test(static_now):
        parser, actual_data, actual_metrics, expected_data, expected_metrics = parser

        # confirm all rows present
        assert actual_data.shape == expected_data.shape
        assert actual_metrics.shape == expected_metrics.shape

        # confirm correct pages processed
        assert parser.page_count == doc[2]
