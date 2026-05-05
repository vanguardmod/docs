# VanguardMod Docs — build entry point
#
# Usage:
#   make pdf       Build the manual PDF
#   make html      Build the single-file HTML manual
#   make clean     Remove all build artefacts
#   make watch     Rebuild PDF on file change (needs entr)

RAW_VERSION := $(shell git describe --tags --always --dirty 2>/dev/null || echo "dev")
VERSION ?= $(if $(filter v%,$(RAW_VERSION)),$(RAW_VERSION),v$(RAW_VERSION))

OUT      := build
MASTER   := book/master.adoc
SOURCES  := $(shell find book cvar -name '*.adoc')
THEME    := theme/vanguardmod-theme.yml

ASCIIDOCTOR     ?= bundle exec asciidoctor
ASCIIDOCTOR_PDF ?= bundle exec asciidoctor-pdf

.PHONY: all pdf html clean watch

all: pdf html

pdf: $(OUT)/vanguardmod-manual.pdf

$(OUT)/vanguardmod-manual.pdf: $(SOURCES) $(THEME)
	@mkdir -p $(OUT)
	$(ASCIIDOCTOR_PDF) \
	    -a pdf-theme=vanguardmod \
	    -a pdf-themesdir=theme \
	    -a vg-version=$(VERSION) \
	    -a revnumber=$(VERSION) \
	    -D $(OUT) \
	    -o vanguardmod-manual.pdf \
	    $(MASTER)

html: $(OUT)/vanguardmod-manual.html

$(OUT)/vanguardmod-manual.html: $(SOURCES)
	@mkdir -p $(OUT)
	$(ASCIIDOCTOR) \
	    -a vg-version=$(VERSION) \
	    -a revnumber=$(VERSION) \
	    -D $(OUT) \
	    -o vanguardmod-manual.html \
	    $(MASTER)

watch:
	@command -v entr >/dev/null || { echo "entr not installed"; exit 1; }
	@find book cvar theme -name '*.adoc' -o -name '*.yml' | entr -c make pdf

clean:
	rm -rf $(OUT)
