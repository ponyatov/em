# DOCMD = ./bin/$(BINFILE) ./lib/$(MODULE).ini

.PHONY: docker
docker: Dockerfile $(BIN)/$(BINFILE)
	docker build -f $< .                      \
          -t $(MODULE):$(BRANCH)
	docker run   -it                          \
        -e MODULE=$(MODULE) -e APP=$(BINFILE) \
        --rm $(MODULE):$(BRANCH)   $(DOCMD)
