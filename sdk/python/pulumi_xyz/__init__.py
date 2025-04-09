# coding=utf-8
# *** WARNING: this file was generated by the Pulumi Terraform Bridge (tfgen) Tool. ***
# *** Do not edit by hand unless you're certain you know what you are doing! ***

import builtins
from . import _utilities
import typing
# Export this package's modules as members:
from .data_source import *
from .provider import *
from .resource import *

# Make subpackages available:
if typing.TYPE_CHECKING:
    import pulumi_xyz.config as __config
    config = __config
    import pulumi_xyz.region as __region
    region = __region
else:
    config = _utilities.lazy_import('pulumi_xyz.config')
    region = _utilities.lazy_import('pulumi_xyz.region')

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
