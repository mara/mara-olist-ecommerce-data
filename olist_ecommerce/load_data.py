import contextlib
import logging
import pathlib

import psycopg2

from olist_ecommerce import config

ECOMMERCE_TABLES = ['ecommerce.customers', 'ecommerce.geolocation', 'ecommerce.order_items',
                    'ecommerce.order_payments',
                    'ecommerce.order_reviews', 'ecommerce.orders', 'ecommerce.products',
                    'ecommerce.sellers', 'ecommerce.product_category_name_translation']

MARKETING_TABLES = ['marketing.closed_deals', 'marketing.marketing_qualified_leads']


@contextlib.contextmanager
def postgres_cursor_context() -> 'psycopg2.extensions.cursor':
    """Creates a context with a psycopg2 cursor for a database alias"""
    import psycopg2
    import psycopg2.extensions

    connection = psycopg2.connect(dbname=config.db_name(), user=config.db_user(), password=config.db_password(),
                                  host=config.db_host(), port=config.db_port())  # type: psycopg2.extensions.connection
    cursor = connection.cursor()  # type: psycopg2.extensions.cursor
    try:
        yield cursor
        connection.commit()
    except Exception as e:
        connection.rollback()
        raise e
    finally:
        cursor.close()
        connection.close()


def create_schema(schema_script):
    """Creates the database schemas"""
    with open(pathlib.Path(__file__).parent / schema_script) as file:
        script = file.read()

    with postgres_cursor_context() as cursor:
        cursor.execute(script)


def insert_data(dataset):
    """Inserts the the csv files in PostgreSQL"""
    sql_statement = """
    COPY {table_name} FROM STDIN WITH
        CSV
        HEADER
        DELIMITER AS ','
        QUOTE '"'
    """

    table_names = ECOMMERCE_TABLES if 'ecommerce' in dataset else MARKETING_TABLES

    pathlist = pathlib.Path(config.data_dir() / dataset).glob('**/*.csv')
    for csv_file, table_name in zip(sorted(pathlist), table_names):
        with open(csv_file) as file:
            with postgres_cursor_context() as cursor:
                cursor.copy_expert(sql=sql_statement.format(table_name=table_name), file=file)


def load_data():
    create_schema('create_ecommerce_schema.sql')
    insert_data('olist-ecommerce')
    print('Schema "ecommerce" created successfully. Tables created: [{}]'.format(', '.join(ECOMMERCE_TABLES)))
    create_schema('create_marketing_schema.sql')
    insert_data('olist-marketing-funnel')
    print('Schema "marketing" created successfully. Tables created: [{}]'.format(', '.join(MARKETING_TABLES)))
