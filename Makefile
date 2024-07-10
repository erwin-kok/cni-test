.DEFAULT_GOAL := build

SUBDIRS := cni-plugin cnitest-node

build: $(SUBDIRS)
	@echo "Build finished."

$(SUBDIRS): force
	@ $(MAKE) $(SUBMAKEOPTS) -C $@ all

image: .buildx_builder
	scripts/build-image.sh linux/amd64,linux/arm64 cnitest "$$(cat .buildx_builder)"

kind: image
	@kind load docker-image cnitest --name cnitest-kind

clean:
	-@for i in $(SUBDIRS); do $(MAKE) $(SUBMAKEOPTS) -C $$i clean; done
	rm -rf ./bin

govet:
	@echo vetting all packages...
	@go vet ./...

gofmt:
	@echo formatting all packages...
	@go fmt ./...

.PHONY: force
force: ;

.buildx_builder:
	mkdir -p ../.buildx
	docker buildx create --platform linux/amd64,linux/arm64 --buildkitd-flags '--debug' > $@

build-container:
	for i in $(SUBDIRS); do $(MAKE) $(SUBMAKEOPTS) -C $$i all; done

install-container-binary:
	@install -m 0755 -d $(DESTDIR)/usr/bin
	for i in $(SUBDIRS); do $(MAKE) $(SUBMAKEOPTS) -C $$i install; done
