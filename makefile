TFLINTRC    := .tflint.hcl
MODULEFILES := $(wildcard *.tf)

.PHONY: default
default: checkfmt docs lint

.PHONY: checkfmt
checkfmt: .fmt

.PHONY: fmt
fmt: $(MODULEFILES)
	terraform fmt
	@touch .fmt

.PHONY: docs
docs: README.md

.PHONY: lint
lint: .lint

.lint: $(MODULEFILES) .lintinit
	tflint --config=$(TFLINTRC)
	@touch .lint

.lintinit: $(TFLINTRC)
	tflint --init --config=$(TFLINTRC)
	@touch .lintinit

README.md: $(MODULEFILES)
	terraform-docs markdown table . --output-file README.md

.fmt: $(MODULEFILES)
	terraform fmt -check
	@touch .fmt

.PHONY: init
init: .init

.init: versions.tf
	terraform init -backend=false
	@touch .init

.PHONY: clean
clean:
	rm -rf .fmt .init .lint .lintinit .terraform
