// *** WARNING: this file was generated by pulumi-java-gen. ***
// *** Do not edit by hand unless you're certain you know what you are doing! ***

package com.pulumi.xyz;

import com.pulumi.core.Output;
import com.pulumi.core.annotations.Export;
import com.pulumi.core.annotations.ResourceType;
import com.pulumi.core.internal.Codegen;
import com.pulumi.xyz.ResourceArgs;
import com.pulumi.xyz.Utilities;
import com.pulumi.xyz.inputs.ResourceState;
import java.lang.String;
import java.util.Optional;
import javax.annotation.Nullable;

@ResourceType(type="xyz:index/resource:Resource")
public class Resource extends com.pulumi.resources.CustomResource {
    /**
     * Sample attribute.
     * 
     */
    @Export(name="sampleAttribute", refs={String.class}, tree="[0]")
    private Output</* @Nullable */ String> sampleAttribute;

    /**
     * @return Sample attribute.
     * 
     */
    public Output<Optional<String>> sampleAttribute() {
        return Codegen.optional(this.sampleAttribute);
    }

    /**
     *
     * @param name The _unique_ name of the resulting resource.
     */
    public Resource(String name) {
        this(name, ResourceArgs.Empty);
    }
    /**
     *
     * @param name The _unique_ name of the resulting resource.
     * @param args The arguments to use to populate this resource's properties.
     */
    public Resource(String name, @Nullable ResourceArgs args) {
        this(name, args, null);
    }
    /**
     *
     * @param name The _unique_ name of the resulting resource.
     * @param args The arguments to use to populate this resource's properties.
     * @param options A bag of options that control this resource's behavior.
     */
    public Resource(String name, @Nullable ResourceArgs args, @Nullable com.pulumi.resources.CustomResourceOptions options) {
        super("xyz:index/resource:Resource", name, args == null ? ResourceArgs.Empty : args, makeResourceOptions(options, Codegen.empty()));
    }

    private Resource(String name, Output<String> id, @Nullable ResourceState state, @Nullable com.pulumi.resources.CustomResourceOptions options) {
        super("xyz:index/resource:Resource", name, state, makeResourceOptions(options, id));
    }

    private static com.pulumi.resources.CustomResourceOptions makeResourceOptions(@Nullable com.pulumi.resources.CustomResourceOptions options, @Nullable Output<String> id) {
        var defaultOptions = com.pulumi.resources.CustomResourceOptions.builder()
            .version(Utilities.getVersion())
            .build();
        return com.pulumi.resources.CustomResourceOptions.merge(defaultOptions, options, id);
    }

    /**
     * Get an existing Host resource's state with the given name, ID, and optional extra
     * properties used to qualify the lookup.
     *
     * @param name The _unique_ name of the resulting resource.
     * @param id The _unique_ provider ID of the resource to lookup.
     * @param state
     * @param options Optional settings to control the behavior of the CustomResource.
     */
    public static Resource get(String name, Output<String> id, @Nullable ResourceState state, @Nullable com.pulumi.resources.CustomResourceOptions options) {
        return new Resource(name, id, state, options);
    }
}