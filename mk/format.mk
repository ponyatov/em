.PHONY: format
format: tmp/format_cpp tmp/format_fsh

tmp/format_cpp: $(C) $(H)
	$(CF) $? && touch $@

tmp/format_fsh: $(F)
	dotnet fantomas --force $? && touch $@
