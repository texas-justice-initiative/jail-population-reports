"""
Confirm converter extracts two CSVs: 
- Raw data from PDF
    - And characteristics on output PDF matches current config values (ie, page number, has total, start row, etc)
- Metrics on PDF conversion accuracy
"""
from pathlib import Path
import pandas as pd
import pytest
import os
from extractor.convert import DOC_CONFIG, PDFConverter


ASSET_PATH: Path = Path.cwd().parent / "assets"


@pytest.fixture(autouse=True)
def parser(doc):
    """Fixture to set up before and clean up after a test is run"""
    # set up test scenario
    doc_type = doc[0]
    doc_path: Path = ASSET_PATH / doc_type
    os.makedirs(doc_path, exist_ok=True)
    expected_data: pd.DataFrame = pd.read_csv(doc_path / f"{doc_type}.csv")
    expected_metrics: pd.DataFrame = pd.read_csv(doc_path / "metrics.csv")

    _parser: PDFConverter = PDFConverter(
        doc_type=doc_type, doc_path=doc_path / f"{doc_type}.pdf"
    )
    actual_data, actual_metrics = _parser.process()

    # output artifacts to be tested
    yield _parser, actual_data, actual_metrics, expected_data, expected_metrics

    # # delete all files when complete
    # shutil.rmtree( / "split")


@pytest.mark.parametrize(
    "doc",
    [("jail_population", 9)],  # dataset name, number of pages in sample doc
)
def test_converter(parser, doc):
    parser, actual_data, actual_metrics, expected_data, expected_metrics = parser

    # confirm all rows present
    assert actual_data.shape == expected_data.shape
    assert actual_metrics.shape == expected_metrics.shape

    # confirm correct pages processed
    assert parser.page_count == doc[1]

    # confirm correct created_at
    # static_now = pendulum.datetime(2021, 3, 11, 12)

    # with pendulum.test(static_now):
