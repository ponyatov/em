MERGE += Makefile README.md LICENSE
MERGE += apt.* .clang-format .doxygen .gitignore
MERGE += $(MK) $(CM) $(C) $(H) $(F) $(P) $(R)
MERGE += .vscode bin doc lib inc src tmp ref
MERGE += hw cpu arch os
MERGE += mk cmake CMake*

.PHONY: dev
dev:
	git push -v
	git checkout $@
	git pull -v
	git checkout shadow -- $(MERGE)
#	$(MAKE) doxy ; git add -f docs

.PHONY: shadow
shadow:
	git push -v
	git checkout $@
	git pull -v

.PHONY: release
release:
	git tag $(NOW)-$(REL)
	git push -v --tags
	$(MAKE) shadow

.PHONY: zip
ZIP = $(APP).$(BRANCH).$(REL).$(USER).$(NOW).zip
zip: tmp/$(ZIP)
tmp/$(ZIP):
	git archive --format=zip -o $@ HEAD
