.PHONY: docker
docker: Dockerfile $(BIN)/$(BINFILE)
	docker build -f $< . -t $(MODULE):$(BRANCH)
	docker run   -it   --rm $(MODULE):$(BRANCH)
