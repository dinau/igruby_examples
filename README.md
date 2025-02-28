<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [IgRuby_Examples](#igruby_examples)
  - [Prerequisites](#prerequisites)
  - [Install Ruby gems](#install-ruby-gems)
  - [Install dlls](#install-dlls)
  - [Screen shots](#screen-shots)
    - [glfw_opengl3, sdl2_opengl3(WIP), sdl2_renderer(WIP)](#glfw_opengl3-sdl2_opengl3wip-sdl2_rendererwip)
    - [glfw_opengl3_jp](#glfw_opengl3_jp)
    - [glfw_opengl3_iconfont_viewer](#glfw_opengl3_iconfont_viewer)
  - [Generating single EXE file on Windows OS with Aibika](#generating-single-exe-file-on-windows-os-with-aibika)
  - [My tools version](#my-tools-version)
  - [Other projects](#other-projects)
  - [Similar project ImGui / CImGui](#similar-project-imgui--cimgui)
  - [SDL Game tutorial Platfromer](#sdl-game-tutorial-platfromer)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## IgRuby_Examples

---

[Ruby-Imgui](https://github.com/vaiorabbit/ruby-imgui) is the wrapper library to use awesome GUI library [Dear ImGui](https://github.com/ocornut/imgui).


This project has some examples using [Ruby-Imgui](https://github.com/vaiorabbit/ruby-imgui) library.

ImGui / CImGui 1.91.8 (2025/02)

### Prerequisites

---

- [x] WindowsOS 10 or later
- [ ] LinuxOS : N/A (Im not familiar with Ruby on Linux OS)
- Ruby 3.1.x or later installed:  https://rubyinstaller.org/downloads/  
OK: with or without Devkit 

### Install Ruby gems

---

Note: Specify imgui-bindings version `0.1.17` at this moment.

```sh
gem install imgui-bindings:0.1.17 sdl2-bindings stbimage aibika 
```

### Install dlls

---

```sh
git clone https://github.com/dinau/igruby_examples
cd igruby_examples
copy dlls_extra\*.dll c:\Ruby34-x64\bin\       # Specify your Ruby bin folder 
```

### Screen shots

------

#### [glfw_opengl3](https://github.com/dinau/igruby_examples/blob/main/glfw_opengl3/glfw_opengl3.rb), sdl2_opengl3(WIP), sdl2_renderer(WIP)

---

Image load and magnifying glass

For executing program for example,

```sh
pwd 
igruby_examples
cd glfw_opengl3
ruby glfw_opengl3.rb    # Or double click glfw_opengl3.rbw in file explorer
```

![alt](img/glfw_opengl3.png)


#### [glfw_opengl3_jp](https://github.com/dinau/igruby_examples/blob/main/glfw_opengl3_jp/glfw_opengl3_jp.rb)
---

Image load and magnifying glass

For executing program for example,

```sh
pwd 
igruby_examples
cd glfw_opengl3_jp
ruby glfw_opengl3_jp.rb    # Or double click glfw_opengl3_jp.rbw in file explorer
```

![alt](img/glfw_opengl3_jp.png)

#### [glfw_opengl3_iconfont_viewer](https://github.com/dinau/igruby_examples/blob/main/glfw_opengl3_iconfont_viewer/glfw_opengl3_iconfont_viewer.rb)
---

Icon fonts viewer

For executing program for example,

```sh
pwd 
igruby_examples
cd glfw_opengl3_iconfont_viewer
ruby glfw_opengl3_iconfont_viewer.rb    # Or double click glfw_opengl3_iconfont_viewer.rbw in file explorer
```

![alt](img/glfw_opengl3_iconfont_viewer.png)

### Generating single EXE file on Windows OS with [Aibika](https://github.com/tamatebako/aibika)

---

For instance,

```sh
pwd 
igruby_examples
cd glfw_opengl3
make 
```

That's all !  
`glfw_opengl3.exe` will be generated in current folder.



### My tools version

---
- Ruby 3.4.2 (2025-02-15 revision d2930f8e7a) +PRISM [x64-mingw-ucrt]
- Cmake version 3.31.4
- Gcc.exe (Rev2, Built by MSYS2 project) 14.2.0
- Git version 2.46.0.windows.1
- Make: GNU Make 4.4.1

### Other projects 

---

- Using Ruby-ImGui project
   - https://github.com/vaiorabbit/blend2d-bindings

### Similar project ImGui / CImGui

---

| Language             |          | Project                                                                                                                                         |
| -------------------: | :---:    | :----------------------------------------------------------------:                                                                              |
| **Nim**              | Compiler | [ImGuin](https://github.com/dinau/imguin), [Nimgl_test](https://github.com/dinau/nimgl_test), [Nim_implot](https://github.com/dinau/nim_implot) |
| **Lua**              | Script   | [LuaJITImGui](https://github.com/dinau/luajitImGui)                                                                                             |
| **Zig**, C lang.     | Compiler | [Dear_Bindings_Build](https://github.com/dinau/dear_bindings_build)                                                                             |
| **Zig**              | Compiler | [ImGuinZ](https://github.com/dinau/imguinz)                                                                                                     |
| **NeLua**            | Compiler | [NeLuaImGui](https://github.com/dinau/neluaImGui)                                                                                               |
| **Python**           | Script   | [DearPyGui for 32bit WindowsOS Binary](https://github.com/dinau/DearPyGui32/tree/win32)                                                         |

### SDL Game tutorial Platfromer

---

![ald](https://github.com/dinau/nelua-platformer/raw/main/img/platformer-nelua-sdl2.gif)

| Language             |          | Project                                                                                                  |
| -------------------: | :---:    | :----------------------------------------------------------------:                                       |
| **Nim**              | Compiler | [Nim-Platformer](https://github.com/dinau/nim-platformer)/ [sdl3_nim](https://github.com/dinau/sdl3_nim) |
| **LuaJIT**           | Script   | [LuaJIT-Platformer](https://github.com/dinau/luajit-platformer)                                          |
| **Nelua**            | Compiler | [NeLua-Platformer](https://github.com/dinau/nelua-platformer)                                            |
| **Zig**              | Compiler | [Zig-Platformer](https://github.com/dinau/zig-platformer)                                                |
