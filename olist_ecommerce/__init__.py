"""Make the functionalities of this package auto-discoverable by mara-app"""


def MARA_CONFIG_MODULES():
    from olist_ecommerce import config
    return [config]


def MARA_CLICK_COMMANDS():
    from olist_ecommerce import cli

    return [cli.load_data]
