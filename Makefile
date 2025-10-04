all:
	echo "make gen"

gen:
	$(MAKE) -C utils/tools/imspinner



RUBY_IMGUI_FILES += ChangeLog
RUBY_IMGUI_FILES += LICENSE.txt
RUBY_IMGUI_FILES += README.md
RUBY_IMGUI_FILES += imgui-bindings.gemspec

RUBY_IMGUI_FILES += lib/glfw3.dll
RUBY_IMGUI_FILES += lib/imgui.dll
RUBY_IMGUI_FILES += lib/imgui.rb
RUBY_IMGUI_FILES += lib/imgui_internal.rb
