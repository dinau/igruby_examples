TARGET = $(notdir $(CURDIR))

ifeq ($(OS),Windows_NT)
	EXE = .exe
endif

ADDED_FILES += ../dlls/glfw3.dll
ADDED_FILES += ../utils/fonticon/fa6/fa-solid-900.ttf
ADDED_FILES += ../utils/r.png

#OPT += --debug-extract
#OPT += --debug
#OPT += --windows
#OPT += --icon res/r.ico
#OPT += --no-lzma

all: $(TARGET)$(EXE)
	aibika $(TARGET).rb $(OPT) $(ADDED_FILES)


$(TARGET)$(EXE): $(TARGET).rb
