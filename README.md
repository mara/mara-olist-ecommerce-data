# Olist E-Commerce Data in PostgreSQL

Stores the [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/olistbr/brazilian-ecommerce)
and the [Marketing Funnel Dataset by Olist](https://www.kaggle.com/olistbr/marketing-funnel-olist) in a PostgreSQL database. 


## Getting started

### Sytem requirements

Python >=3.6 and PostgreSQL >=10 and some smaller packages are required to load the data. 

On Mac, install Postgresql with `brew install -v postgresql`. On Ubuntu, follow  [these instructions](https://www.postgresql.org/download/linux/ubuntu/).

Start a database client with `sudo -u postgres psql postgres` and then create a user with `CREATE ROLE root SUPERUSER LOGIN;` (you can use any other name).  

### Installation

Log into PostgreSQL with `psql -U root postgres` and create the database:

```sql
CREATE DATABASE olist_ecommerce;
```


The easiest way to install mara-olist-ecommerce-data is using pip

    pip install git+https://github.com/mara/mara-olist-ecommerce-data.git

In case you want to install it in a virtual environment:

    $ git clone git@github.com:mara/mara-olist-ecommerce-data.git
    $ cd mara-olist-ecommerce-data
    $ python3 -m venv .venv
    $ .venv/bin/pip install .

## Usage

To load the Olist data int PostgreSQL `load-olist-ecommerce-data` with its config parameters:  

    $ load-olist-ecommerce-data --db_name olist_ecommerce \
    --db_user root \
    --db_host localhost \
    --db_port 5432
    
For all options, see 

    $ load-olist-ecommerce-data --help
    Usage: load-olist-ecommerce-data [OPTIONS]
    
      Loads the Olist e-commerce data into PostreSQL. When options are not
      specified, then the defaults from config.py are used.
    
    Options:
      --data_dir TEXT     The directory where the csv files are located. Default:
                          "data"
    
      --db_name TEXT      Database name. Default: "olist_ecommerce"
      --db_user TEXT      Database user. Default: "root"
      --db_password TEXT  Database password. Default: ""
      --db_host TEXT      Database host. Default: "localhost"
      --db_port TEXT      Database port. Default: "5432"
      --help              Show this message and exit.
