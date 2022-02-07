{% docs __overview__ %}
# Jail Population Reports Database

This is a consolidated view of four monthly reports published by the [Texas Commission on Jail Standards (TCJS)](https://www.tcjs.state.tx.us/population-reports/). These monthly PDF reports have been converted into a tabular format and loaded into a postgres database. In addition to utilizing this data for Texas Justice Initiative's own projects, we're making the entire process available so anyone can launch their own version of this data warehouse.

The four reports processed are:
- Jail Population Report
- Pregnant Inmate Report
- Immigration Detainer Report
- Serious Incidents Report

The data pipeline follows an Extract-Load-Transform pattern, and effort has been taken to do as much of the data cleaning and manipulation via SQL. The objective is to improve transparency into any changes made from the original PDF report. You can access the code used to generate this project on [GitHub](https://github.com/texas-justice-initiative/jail-population-reports/). We're using [DBT](https://docs.getdbt.com/docs/introduction) (data build tool) to generate the final data warehouse.

# How to use this site
### Navigation

You can use the `Project` and `Database` navigation tabs on the left side of the window to explore the models in the project.

### Project Tab

The `Project` tab mirrors the directory structure of this project. In this tab, you can see all of the models defined in your dbt project, as well as models imported from dbt packages.

### Database Tab

The `Database` tab also exposes your models, but in a format that looks more like a database explorer. This view shows relations (tables and views) grouped into database schemas. Note that ephemeral models are not shown in this interface, as they do not exist in the database.

### Graph Exploration

You can click the blue icon on the bottom-right corner of the page to view the lineage graph of your models.

On model pages, you'll see the immediate parents and children of the model you're exploring. By clicking the `Expand` button at the top-right of this lineage pane, you'll be able to see all of the models that are used to build, or are built from, the model you're exploring.

Once expanded, you'll be able to use the `--select` and `--exclude` model selection syntax to filter the models in the graph. For more information on model selection, [check out the dbt docs](https://docs.getdbt.com/docs/model-selection-syntax).

Note that you can also right-click on models to interactively filter and explore the graph.

# About Texas Justice Initiative

Texas Justice Initiative is a nonprofit organization that collects, analyzes, publishes and provides oversight for criminal justice data throughout Texas. [Learn more](https://texasjusticeinitiative.org/).

{% enddocs %}
