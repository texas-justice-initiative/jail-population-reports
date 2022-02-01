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
7. Exit the poetry environment (`exit` or control d) before setting up the second environment, and restart the process again

#### Setting up DBT connection

DBT requires a profile to connect to the database. The default location is in `~/.dbt/profiles.yaml`.

Your file should look like this for this project:
```yaml
tji_warehouse: # this needs to match the profile: in your dbt_project.yml file
  target: dev  # local development should go to a dev environment
  outputs:
    dev:
      type: postgres
      host: {URI for database}
      # user/password auth
      user: {username} # need to give dbt pipeline auth to edit this
      password: {password}
      port: 5432
      dbname: warehouse # name of the database
      schema: dbt_{your name}  # for local development, this is a good pattern to follow
      threads: 4
```

To generate the SQL used to build the database, use `dbt compile`; to create or update the tables themeselves, run `dbt run`

More info [here](https://docs.getdbt.com/tutorial/setting-up).
