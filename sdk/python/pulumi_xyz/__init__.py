# coding=utf-8
# *** WARNING: this file was generated by the Pulumi Terraform Bridge (tfgen) Tool. ***
# *** Do not edit by hand unless you're certain you know what you are doing! ***

from . import _utilities
import typing
# Export this package's modules as members:
from .data_source import *
from .get_data_source import *
from .provider import *
from .resource import *
_utilities.register(
    resource_modules="""
[
 {
  "pkg": "xyz",
  "mod": "index/resource",
  "fqn": "pulumi_xyz",
  "classes": {
   "xyz:index/resource:Resource": "Resource"
  }
 }
]
""",
    resource_packages="""
[
 {
  "pkg": "xyz",
  "token": "pulumi:providers:xyz",
  "fqn": "pulumi_xyz",
  "class": "Provider"
 }
]
"""
)