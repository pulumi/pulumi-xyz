// *** WARNING: this file was generated by pulumi-java-gen. ***
// *** Do not edit by hand unless you're certain you know what you are doing! ***

package com.pulumi.xyz;

import com.pulumi.core.internal.Codegen;
import com.pulumi.xyz.region.enums.Region;
import java.util.Optional;

public final class Config {

    private static final com.pulumi.Config config = com.pulumi.Config.of("xyz");
/**
 * A region which should be used.
 * 
 */
    public Optional<Region> region() {
        return Codegen.objectProp("region", Region.class).config(config).get();
    }
}