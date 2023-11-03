# -----------------------------------------------------------------------------
# variables/constants
# -----------------------------------------------------------------------------

TL_YEAR = 2022


# -----------------------------------------------------------------------------
# targets
# -----------------------------------------------------------------------------

.PHONY: help

# The idea of the help target is to print out a 'help' for the user that lists
# all targets and explains them. Each target that is supposed to be listed in
# the help must be commented like this:
# 
# ## <TARGET NAME>: This is a description of the target. In case the
# ## description is to long for one line, it can be split like this.
# <TARGET NAME>: dependencies
# [TAB]recipe

## help: Show this help
help: Makefile
	@echo ""
	@echo "The following targets exist:"
	@sed -n -e '/^## \S/ s/^## //p' -e 's/^## \s\+/: /p' $< | \
		awk -F ": " '{printf "\033[33m%-20s\033[0m%s\n", $$1, $$2};'
	@echo ""


## image: Build the podman image
image:
	podman build \
		--build-arg TL_YEAR=$(TL_YEAR) \
		-t schuam/docgen:latest \
		-t schuam/docgen:`git describe --tags --dirty` \
		.

