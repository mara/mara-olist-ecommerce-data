"""Command line interface for load the olist-ecommerce data into PostgreSQL"""

import logging
from functools import partial

import click

from olist_ecommerce import config


def config_option(config_function):
    """Helper decorator that turns an option function into a cli option"""
    return (lambda function: click.option('--' + config_function.__name__,
                                          help=config_function.__doc__.strip() + '. Default: "' +
                                               str(config_function()) + '"')(function))


def apply_options(kwargs):
    """Applies passed cli parameters to config.py"""
    for key, value in kwargs.items():
        if value: setattr(config, key, partial(lambda v: v, value))


@click.command()
@config_option(config.data_dir)
@config_option(config.db_name)
@config_option(config.db_user)
@config_option(config.db_password)
@config_option(config.db_host)
@config_option(config.db_port)
def load_data(**kwargs):
    """
    Loads the Olist e-commerce data into PostreSQL.
    When options are not specified, then the defaults from config.py are used.
    """
    from olist_ecommerce import load_data

    apply_options(kwargs)
    load_data.load_data()
