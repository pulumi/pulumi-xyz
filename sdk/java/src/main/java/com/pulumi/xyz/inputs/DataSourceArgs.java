// *** WARNING: this file was generated by pulumi-java-gen. ***
// *** Do not edit by hand unless you're certain you know what you are doing! ***

package com.pulumi.xyz.inputs;

import com.pulumi.core.Output;
import com.pulumi.core.annotations.Import;
import com.pulumi.exceptions.MissingRequiredPropertyException;
import java.lang.String;
import java.util.Objects;


public final class DataSourceArgs extends com.pulumi.resources.InvokeArgs {

    public static final DataSourceArgs Empty = new DataSourceArgs();

    @Import(name="sampleAttribute", required=true)
    private Output<String> sampleAttribute;

    public Output<String> sampleAttribute() {
        return this.sampleAttribute;
    }

    private DataSourceArgs() {}

    private DataSourceArgs(DataSourceArgs $) {
        this.sampleAttribute = $.sampleAttribute;
    }

    public static Builder builder() {
        return new Builder();
    }
    public static Builder builder(DataSourceArgs defaults) {
        return new Builder(defaults);
    }

    public static final class Builder {
        private DataSourceArgs $;

        public Builder() {
            $ = new DataSourceArgs();
        }

        public Builder(DataSourceArgs defaults) {
            $ = new DataSourceArgs(Objects.requireNonNull(defaults));
        }

        public Builder sampleAttribute(Output<String> sampleAttribute) {
            $.sampleAttribute = sampleAttribute;
            return this;
        }

        public Builder sampleAttribute(String sampleAttribute) {
            return sampleAttribute(Output.of(sampleAttribute));
        }

        public DataSourceArgs build() {
            if ($.sampleAttribute == null) {
                throw new MissingRequiredPropertyException("DataSourceArgs", "sampleAttribute");
            }
            return $;
        }
    }

}