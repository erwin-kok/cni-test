include ../Makefile.defs

TARGET := ./bin/test-cni
LDFLAGS = -X main.VERSION=$(GIT_VERSION)

.PHONY: all $(TARGET) clean

all: $(TARGET)

$(TARGET):
	@echo "  GO     $(RELATIVE_DIR)/$@"
	@CGO_ENABLED=0 go build -o $@ -v -buildvcs=false -ldflags "$(LDFLAGS)"

clean:
	@echo "  CLEAN  $(RELATIVE_DIR)"
	-@rm -rf ./bin
	@go clean

install:
	echo "############## $(DESTDIR)"
	@install -m 0755 -d $(DESTDIR)/etc/cni/net.d
	@install -m 0644 test-cni.conf $(DESTDIR)/etc/cni/net.d
	@install -m 0755 -d $(DESTDIR)/opt/cni/bin
	@install -m 0755 $(TARGET) $(DESTDIR)/opt/cni/bin
