# coding=utf-8
# *** WARNING: this file was generated by pulumi-language-python. ***
# *** Do not edit by hand unless you're certain you know what you are doing! ***

import builtins as _builtins
import pulumi
from enum import Enum

__all__ = [
    'Region',
]


@pulumi.type_token("xyz:region/region:Region")
class Region(_builtins.str, Enum):
    HERE = "HERE"
    OVER_THERE = "OVER_THERE"
