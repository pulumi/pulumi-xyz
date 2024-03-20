package provider

import (
	"testing"

	"github.com/pulumi/pulumi-xyz/provider/pkg/version"
)

func TestProvider(_ *testing.T) {
	version.Version = "1.0.0"
	Provider()
}
