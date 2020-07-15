from setuptools import setup, find_packages

setup(
    name='mara-olist-ecommerce-data',
    version='1.0.0',

    description=("Stores the brazilian e-commerce and marketing-funnel public data by Olist "
                 "in a PostgreSQL database"),

    install_requires=[
        'psycopg2',
        'click>=6.0',
        'wheel>=0.29'
    ],

    include_package_data=True,

    packages=find_packages(),

    author='Mara contributors',
    license='MIT',

    entry_points={
        'console_scripts': [
            'load-olist-ecommerce-data=olist_ecommerce.cli:load_data'
        ]
    }
)
