// *** WARNING: this file was generated by the Pulumi Terraform Bridge (tfgen) Tool. ***
// *** Do not edit by hand unless you're certain you know what you are doing! ***

using System;
using System.Collections.Generic;
using System.Collections.Immutable;
using System.Threading.Tasks;
using Pulumi.Serialization;

namespace Pulumi.Xyz
{
    [Obsolete(@"xyz.index/getdatasource.getDataSource has been deprecated in favor of xyz.index/datasource.DataSource")]
    public static class GetDataSource
    {
        public static Task<GetDataSourceResult> InvokeAsync(GetDataSourceArgs args, InvokeOptions? options = null)
            => global::Pulumi.Deployment.Instance.InvokeAsync<GetDataSourceResult>("xyz:index/getDataSource:getDataSource", args ?? new GetDataSourceArgs(), options.WithDefaults());

        public static Output<GetDataSourceResult> Invoke(GetDataSourceInvokeArgs args, InvokeOptions? options = null)
            => global::Pulumi.Deployment.Instance.Invoke<GetDataSourceResult>("xyz:index/getDataSource:getDataSource", args ?? new GetDataSourceInvokeArgs(), options.WithDefaults());
    }


    public sealed class GetDataSourceArgs : global::Pulumi.InvokeArgs
    {
        [Input("sampleAttribute", required: true)]
        public string SampleAttribute { get; set; } = null!;

        public GetDataSourceArgs()
        {
        }
        public static new GetDataSourceArgs Empty => new GetDataSourceArgs();
    }

    public sealed class GetDataSourceInvokeArgs : global::Pulumi.InvokeArgs
    {
        [Input("sampleAttribute", required: true)]
        public Input<string> SampleAttribute { get; set; } = null!;

        public GetDataSourceInvokeArgs()
        {
        }
        public static new GetDataSourceInvokeArgs Empty => new GetDataSourceInvokeArgs();
    }


    [OutputType]
    public sealed class GetDataSourceResult
    {
        /// <summary>
        /// The provider-assigned unique ID for this managed resource.
        /// </summary>
        public readonly string Id;
        public readonly string SampleAttribute;

        [OutputConstructor]
        private GetDataSourceResult(
            string id,

            string sampleAttribute)
        {
            Id = id;
            SampleAttribute = sampleAttribute;
        }
    }
}
