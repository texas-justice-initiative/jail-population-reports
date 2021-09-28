from datetime import datetime
from pathlib import Path

import requests

BASE_URL: str = "https://www.tcjs.state.tx.us/wp-content/uploads"
FILENAMES = {
    "jail_population": "AbbreRptCurrent.pdf",
    "pregnancies": "PregnantFemaleReportingCurrent.pdf",
    "immigration": "ImmigrationDetainerReportCurrent.pdf",
}

# dates are two-digit month and 4-digit years
# URL format: {BASE}/{YEAR}/{MONTH}/{FILENAME}


class TCJSConnection:
    # def list_files(file_slug: str, start: datetime, end: datetime) -> None:
    #     pass

    def download(file_slug: str, data_date: datetime, output: Path) -> None:
        # TODO:
        # function to create paths if DNE
        # convert data date to month/year format

        output_file: Path = Path.cwd() / "warehouse/data/pdf/2021/09"

        with open(output_file / f"{file_slug}.pdf", "wb") as output_file:
            file_contents: requests.Response = requests.get(
                f"{BASE_URL}/2021/09/{FILENAMES[file_slug]}"
            )
            # if file_contents.status_code == '200':
            #     # add log message
            output_file.write(file_contents.content)
