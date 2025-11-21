CC = gcc
CFLAGS_COMMON = -Wall -Wextra
CFLAGS_RELEASE = -O3 -march=native -DNDEBUG
CFLAGS_DEBUG = -O0 -g -fsanitize=address
LDFLAGS = -lcrypto -lssl
TARGET = pwg 
SRC = main.c

RELEASE_DIR = release
DEBUG_DIR = debug

# Default to release build
all: release

release: $(RELEASE_DIR)/$(TARGET)

debug: $(DEBUG_DIR)/$(TARGET)

$(RELEASE_DIR)/$(TARGET): $(SRC)
	mkdir -p $(RELEASE_DIR)
	$(CC) $(CFLAGS_COMMON) $(CFLAGS_RELEASE) -fomit-frame-pointer $(SRC) -o $@ $(LDFLAGS)

$(DEBUG_DIR)/$(TARGET): $(SRC)
	mkdir -p $(DEBUG_DIR)
	$(CC) $(CFLAGS_COMMON) $(CFLAGS_DEBUG) $(SRC) -o $@ $(LDFLAGS) -fsanitize=address

clean:
	rm -rf $(RELEASE_DIR) $(DEBUG_DIR)

install: release
	install -m 755 $(RELEASE_DIR)/$(TARGET) ~/.local/bin/

.PHONY: all release debug clean install
