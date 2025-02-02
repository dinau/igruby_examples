TARGET  = glfw_opengl3_jp

CUR_FILES += ../dlls/glfw3.dll
CUR_FILES += ../utils/fonticon/fa6/fa-solid-900.ttf
CUR_FILES += res/r.png res/r.ico
CUR_FILES += himeji-400.jpg
#RBIN_DIR = ruby_builtin_dlls
#RBIN_DLLS += --dll libgcc_s_seh-1.dll
#RBIN_DLLS += --dll libstdc++-6.dll
#RBIN_DLLS += --dll libwinpthread-1.dll

#OPT += --debug-extract
#OPT += --debug
OPT += --windows
OPT += --icon res/r.ico

all:
	aibika $(TARGET).rb $(OPT) $(CUR_FILES) $(RBIN_DLLS)
