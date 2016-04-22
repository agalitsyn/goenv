PACKAGES := golang.org/x/tools/cmd/oracle \
	golang.org/x/tools/cmd/goimports \
	github.com/golang/lint/golint \
	github.com/kisielk/errcheck \
	github.com/nsf/gocode \
	github.com/rogpeppe/godef \
	github.com/jstemmer/gotags \
	golang.org/x/tools/cmd/gorename \
	github.com/josharian/impl \
	github.com/mattn/goreman \
	github.com/tools/godep

install-go-tools:
	$(foreach pkg,$(PACKAGES),go get -u $(pkg);)

init-go-path:
	bash ./scripts/init-go-path.sh

get-example:
	go get -u github.com/golang/example/outyet

install-example:
	go install github.com/golang/example/outyet

test-example:
	go test -v github.com/golang/example/outyet

run-example:
	outyet --http 0.0.0.0:8080 --version 1.6

test-end-to-end-example:
	@-curl 0.0.0.0:8080
