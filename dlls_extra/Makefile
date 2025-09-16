all:
	@echo Do: $ make dll

DLL_DIR = c:/drvdx/msys64/mingw64/bin

VERSION_TEXT = version.txt

dll:
	cp -f $(DLL_DIR)/libgcc_s_seh-1.dll     .
	cp -f $(DLL_DIR)/libstdc++-6.dll        .
	cp -f $(DLL_DIR)/libwinpthread-1.dll    .
	pacman -Ss mingw-w64-x86_64-gcc | rg "gcc "  > $(VERSION_TEXT)
