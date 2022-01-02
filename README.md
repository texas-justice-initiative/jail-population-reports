# Jail Population Reports
Scraping/Extracting data from TJI


### Setup

There are two distinct batches of code housed in this repository:
    - A tool for downloading, parsing, and uploading TCJS data
    - Configuration for the data warehouse and the code to generate the downstream cleaned versions of the TCJS reports

You will need to set up an environment for working on each of these projects.

1. Install base dependencies (pyenv/poetry/python)
2. Set base python version via pyenv (currently 3.9.0)
3. Change into desired directory (`cd extractor` or `cd warehouse`)
4. Run `poetry install`
5. Start up resulting environment (`poetry shell`)
6. Install pre-commit hooks in that environment (`pre-commit install -c extractor/.pre-commit-config.yaml`) (does this need to be done from root project?)

~~ EXIT THE POETRY ENVIRONMENT (`exit` or `{control} d`) before setting up the second environment, and restart the process again

#### Setting up DBT connection
