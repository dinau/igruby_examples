TARGET = $(notdir $(CURDIR))

ifeq ($(OS),Windows_NT)
	EXE = .exe
endif

CUR_FILES += ../dlls/glfw3.dll
CUR_FILES += ../utils/fonticon/fa6/fa-solid-900.ttf
CUR_FILES += res/r.png res/r.ico
CUR_FILES += img/himeji-400.jpg

#OPT += --debug-extract
#OPT += --debug
OPT += --windows
OPT += --icon res/r.ico

all:
	aibika $(TARGET).rb $(OPT) $(CUR_FILES) $(RBIN_DLLS)


$(TARGET)$(EXE): $(TARGET).rb
