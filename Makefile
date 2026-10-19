BASH_FILES = bansi-to-html tools/style-check test/run test/remake-expected
ALL_FILES = $(BASH_FILES) README.md

.PHONY: test
test:
	(cd test && make)

.PHONY: check
check:
	./tools/style-check $(ALL_FILES)
	shellcheck $(BASH_FILES)
