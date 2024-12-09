// *** WARNING: this file was generated by the Pulumi Terraform Bridge (tfgen) Tool. ***
// *** Do not edit by hand unless you're certain you know what you are doing! ***

import * as pulumi from "@pulumi/pulumi";
import * as utilities from "./utilities";

export function dataSource(args: DataSourceArgs, opts?: pulumi.InvokeOptions): Promise<DataSourceResult> {
    opts = pulumi.mergeOptions(utilities.resourceOptsDefaults(), opts || {});
    return pulumi.runtime.invoke("xyz:index/dataSource:DataSource", {
        "sampleAttribute": args.sampleAttribute,
    }, opts);
}

/**
 * A collection of arguments for invoking DataSource.
 */
export interface DataSourceArgs {
    sampleAttribute: string;
}

/**
 * A collection of values returned by DataSource.
 */
export interface DataSourceResult {
    /**
     * The provider-assigned unique ID for this managed resource.
     */
    readonly id: string;
    readonly sampleAttribute: string;
}
export function dataSourceOutput(args: DataSourceOutputArgs, opts?: pulumi.InvokeOutputOptions): pulumi.Output<DataSourceResult> {
    opts = pulumi.mergeOptions(utilities.resourceOptsDefaults(), opts || {});
    return pulumi.runtime.invokeOutput("xyz:index/dataSource:DataSource", {
        "sampleAttribute": args.sampleAttribute,
    }, opts);
}

/**
 * A collection of arguments for invoking DataSource.
 */
export interface DataSourceOutputArgs {
    sampleAttribute: pulumi.Input<string>;
}
