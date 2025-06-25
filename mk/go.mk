.PHONY: go
go: $(GO) $(GOPLS)
	$(GO) version ; $(GOPLS) version

GO_SRC = go-$(GO_VER)
GO_GZ  = go$(GO_VER).linux-amd64.tar.gz
GO_URL = https://go.dev/dl/$(GO_GZ)

$(GO): $(DISTR)/go/$(GO_GZ)
	sudo tar -C /usr/local -xzf $< && sudo touch $@
$(GOPLS): $(GO)
	go install golang.org/x/tools/gopls@latest
	go install github.com/go-delve/delve/cmd/dlv@latest
	go install golang.org/x/tools/staticcheck@latest
	go install github.com/cweill/gotests/gotests@latest

GZ += $(DISTR)/go/$(GO_GZ)
$(DISTR)/go/$(GO_GZ):
	mkdir -p $(DISTR)/go
	$(CURL) $@ $(GO_URL)
