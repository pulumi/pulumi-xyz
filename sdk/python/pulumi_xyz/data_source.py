# coding=utf-8
# *** WARNING: this file was generated by the Pulumi Terraform Bridge (tfgen) Tool. ***
# *** Do not edit by hand unless you're certain you know what you are doing! ***

import copy
import warnings
import sys
import pulumi
import pulumi.runtime
from typing import Any, Mapping, Optional, Sequence, Union, overload
if sys.version_info >= (3, 11):
    from typing import NotRequired, TypedDict, TypeAlias
else:
    from typing_extensions import NotRequired, TypedDict, TypeAlias
from . import _utilities

__all__ = [
    'DataSourceResult',
    'AwaitableDataSourceResult',
    'data_source',
    'data_source_output',
]

@pulumi.output_type
class DataSourceResult:
    """
    A collection of values returned by DataSource.
    """
    def __init__(__self__, id=None, sample_attribute=None):
        if id and not isinstance(id, str):
            raise TypeError("Expected argument 'id' to be a str")
        pulumi.set(__self__, "id", id)
        if sample_attribute and not isinstance(sample_attribute, str):
            raise TypeError("Expected argument 'sample_attribute' to be a str")
        pulumi.set(__self__, "sample_attribute", sample_attribute)

    @property
    @pulumi.getter
    def id(self) -> str:
        """
        The provider-assigned unique ID for this managed resource.
        """
        return pulumi.get(self, "id")

    @property
    @pulumi.getter(name="sampleAttribute")
    def sample_attribute(self) -> str:
        return pulumi.get(self, "sample_attribute")


class AwaitableDataSourceResult(DataSourceResult):
    # pylint: disable=using-constant-test
    def __await__(self):
        if False:
            yield self
        return DataSourceResult(
            id=self.id,
            sample_attribute=self.sample_attribute)


def data_source(sample_attribute: Optional[str] = None,
                opts: Optional[pulumi.InvokeOptions] = None) -> AwaitableDataSourceResult:
    """
    Use this data source to access information about an existing resource.
    """
    __args__ = dict()
    __args__['sampleAttribute'] = sample_attribute
    opts = pulumi.InvokeOptions.merge(_utilities.get_invoke_opts_defaults(), opts)
    __ret__ = pulumi.runtime.invoke('xyz:index/dataSource:DataSource', __args__, opts=opts, typ=DataSourceResult).value

    return AwaitableDataSourceResult(
        id=pulumi.get(__ret__, 'id'),
        sample_attribute=pulumi.get(__ret__, 'sample_attribute'))
def data_source_output(sample_attribute: Optional[pulumi.Input[str]] = None,
                       opts: Optional[Union[pulumi.InvokeOptions, pulumi.InvokeOutputOptions]] = None) -> pulumi.Output[DataSourceResult]:
    """
    Use this data source to access information about an existing resource.
    """
    __args__ = dict()
    __args__['sampleAttribute'] = sample_attribute
    opts = pulumi.InvokeOutputOptions.merge(_utilities.get_invoke_opts_defaults(), opts)
    __ret__ = pulumi.runtime.invoke_output('xyz:index/dataSource:DataSource', __args__, opts=opts, typ=DataSourceResult)
    return __ret__.apply(lambda __response__: DataSourceResult(
        id=pulumi.get(__response__, 'id'),
        sample_attribute=pulumi.get(__response__, 'sample_attribute')))
