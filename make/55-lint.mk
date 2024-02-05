# This file was generated by @liquid-labs/sdlc-projects-workflow-local-node-build.
# Refer to https://npmjs.com/package/@liquid-labs/sdlc-projects-workflow-local-
# node-build for further details

#####
# lint rules
#####

SDLC_LINT_REPORT:=$(QA)/lint.txt
SDLC_LINT_PASS_MARKER:=$(QA)/.lint.passed
LINT_TARGETS+=$(SDLC_LINT_REPORT) $(SDLC_LINT_PASS_MARKER)
PRECIOUS_TARGETS+=$(SDLC_LINT_REPORT)

$(SDLC_LINT_REPORT) $(SDLC_LINT_PASS_MARKER): $(SDLC_ALL_JS_FILES_SRC)
	mkdir -p $(dir $@)
	echo -n 'Test git rev: ' > $(SDLC_LINT_REPORT)
	git rev-parse HEAD >> $(SDLC_LINT_REPORT)
	( set -e; set -o pipefail; \
		ESLINT_USE_FLAT_CONFIG=true \
	  $(SDLC_ESLINT) \
	    --config $(SDLC_ESLINT_CONFIG) \
	    . \
	    | tee -a $(SDLC_LINT_REPORT); \
	  touch $(SDLC_LINT_PASS_MARKER) )

lint-fix:
	@( set -e; set -o pipefail; \
		ESLINT_USE_FLAT_CONFIG=true \
	  $(SDLC_ESLINT) \
	    --config $(SDLC_ESLINT_CONFIG) \
	    --fix . )

#####
# end lint
#####