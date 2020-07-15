"""Configuration of loading olist e-commerce dataset to Postgres"""

import pathlib


def data_dir() -> str:
    """The directory where the csv files are located"""
    return pathlib.Path(__file__).parent.parent/'data'


def db_name() -> str:
    """Database name"""
    return 'olist_ecommerce'


def db_user() -> str:
    """Database user"""
    return 'root'


def db_password() -> str:
    """Database password"""
    return ''


def db_host() -> str:
    """Database host"""
    return 'localhost'


def db_port() -> str:
    """Database port"""
    return '5432'
