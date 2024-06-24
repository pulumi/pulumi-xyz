// *** WARNING: this file was generated by pulumi-java-gen. ***
// *** Do not edit by hand unless you're certain you know what you are doing! ***

package com.pulumi.xyz;

import com.pulumi.core.Output;
import com.pulumi.core.annotations.Import;
import java.lang.String;
import java.util.Objects;
import java.util.Optional;
import javax.annotation.Nullable;


public final class ResourceArgs extends com.pulumi.resources.ResourceArgs {

    public static final ResourceArgs Empty = new ResourceArgs();

    /**
     * Sample attribute.
     * 
     */
    @Import(name="sampleAttribute")
    private @Nullable Output<String> sampleAttribute;

    /**
     * @return Sample attribute.
     * 
     */
    public Optional<Output<String>> sampleAttribute() {
        return Optional.ofNullable(this.sampleAttribute);
    }

    private ResourceArgs() {}

    private ResourceArgs(ResourceArgs $) {
        this.sampleAttribute = $.sampleAttribute;
    }

    public static Builder builder() {
        return new Builder();
    }
    public static Builder builder(ResourceArgs defaults) {
        return new Builder(defaults);
    }

    public static final class Builder {
        private ResourceArgs $;

        public Builder() {
            $ = new ResourceArgs();
        }

        public Builder(ResourceArgs defaults) {
            $ = new ResourceArgs(Objects.requireNonNull(defaults));
        }

        /**
         * @param sampleAttribute Sample attribute.
         * 
         * @return builder
         * 
         */
        public Builder sampleAttribute(@Nullable Output<String> sampleAttribute) {
            $.sampleAttribute = sampleAttribute;
            return this;
        }

        /**
         * @param sampleAttribute Sample attribute.
         * 
         * @return builder
         * 
         */
        public Builder sampleAttribute(String sampleAttribute) {
            return sampleAttribute(Output.of(sampleAttribute));
        }

        public ResourceArgs build() {
            return $;
        }
    }

}