include ../Makefile.defs

TARGET := ./bin/cnitest-node
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
	@install -m 0755 -d $(DESTDIR)/usr/bin
	@install -m 0755 $(TARGET) $(DESTDIR)/usr/bin
