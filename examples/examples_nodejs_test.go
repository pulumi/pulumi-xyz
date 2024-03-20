//go:build nodejs || all
// +build nodejs all

package examples

import (
	"path/filepath"
	"testing"

	"github.com/pulumi/pulumi/pkg/v3/testing/integration"
)

func getJSBaseOptions() integration.ProgramTestOptions {
	base := getBaseOptions()
	baseJS := base.With(integration.ProgramTestOptions{
		Dependencies: []string{
			"@pulumi/xyz",
		},
	})

	return baseJS
}

func TestBasic(t *testing.T) {
	opts := getJSBaseOptions()
	opts = opts.With(integration.ProgramTestOptions{
        Dir: filepath.Join(getCwd(t), "basic"),
		Quick: true,
		SkipUpdate: true,
    })

	integration.ProgramTest(t, &opts)
}