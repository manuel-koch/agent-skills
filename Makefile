REPO_ROOT := $(realpath $(dir $(abspath $(firstword $(MAKEFILE_LIST)))))

# Run rumdl to enforce consistent formatting of Markdown files
.PHONY: format
format:
	rumdl fmt --quiet $(REPO_ROOT)
