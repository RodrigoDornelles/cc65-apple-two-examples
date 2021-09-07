.PHONY: cc65

OUT_DIR := bin
CC65_DIR := cc65
TOOL_DIR := tools

CC := $(CC65_DIR)/bin/cc65
CL := $(CC65_DIR)/bin/cl65
SOURCE := program.c
TARGET_PLATFORM := apple2

AC := $(TOOL_DIR)/AppleCommander-macosx-1.5.0.jar.jar
EMULATOR := $(TOOL_DIR)/izapple2sdl_macos

clean:
	@rm $(OUT_DIR)/* 2>/dev/null; true

cc65:
	$(MAKE) -C cc65

hello: clean
	cp template.dsk $(OUT_DIR)/hello.dsk
	$(CL) -t $(TARGET_PLATFORM) $(SOURCE) -o $(OUT_DIR)/hello.apple2
	java -jar $(AC) -p $(OUT_DIR)/hello.dsk hello.system sys < cc65/target/apple2/util/loader.system
	java -jar $(AC) -as $(OUT_DIR)/hello.dsk hello bin < $(OUT_DIR)/hello.apple2
	rm $(OUT_DIR)/hello.apple2
	chmod +x $(OUT_DIR)/hello.dsk

run:
	$(EMULATOR) $(OUT_DIR)/hello.dsk