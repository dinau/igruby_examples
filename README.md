<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [IgRuby Examples](#igruby-examples)
  - [Prerequisites](#prerequisites)
  - [Donwload and running examples on Windows OS](#donwload-and-running-examples-on-windows-os)
  - [Snapshots](#snapshots)
    - [ImGui-Toggle / CImGui-Toggle](#imgui-toggle--cimgui-toggle)
    - [ImDrawList party](#imdrawlist-party)
    - [ImGui-Knobs / CImGui-Knobs](#imgui-knobs--cimgui-knobs)
    - [ImSpinner / CImSpinner](#imspinner--cimspinner)
    - [ImGuizmo / CImGuizmo](#imguizmo--cimguizmo)
    - [ImGuiColorTextEdit / cimCTE](#imguicolortextedit--cimcte)
    - [ImNodes / CImNodes](#imnodes--cimnodes)
    - [ImGuiFileDialog](#imguifiledialog)
    - [Iconfonts viewer](#iconfonts-viewer)
    - [Image loading](#image-loading)
    - [Showing CJK fonts](#showing-cjk-fonts)
  - [For Linux x86_64](#for-linux-x86_64)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

### IgRuby Examples

---

Ruby language + [Dear ImGui](https://github.com/ocornut/imgui) + Additional libraries and examples project

See [ruby-imgui-dev](https://github.com/dinau/ruby-imgui-dev) 

#### Prerequisites

---

✅ Windows11 or later  
- Install [RubyInstaller + **Devkit** ](https://rubyinstaller.org/downloads/) 3.4.7 or later  
  (You must install Devkit)

✅  Linux OS x86_64 
- Debian13 Trixie, Ubuntu families and Windows WSL2


#### Donwload and running examples on Windows OS
---

1. Download `igruby_examples-1.9x.y-bdn.zip` from [Release page](https://github.com/dinau/igruby_examples/releases) then extract zip file.
1. Execute bundler command,

   ```sh
   $ cd igruby_examples-1.91.8-bd2/igruby_examples
   $ bundle install

   Fetching gem metadata from https://rubygems.org/..
   Resolving dependencies...
   Bundle complete! 6 Gemfile dependencies, 9 gems now installed.
   Use `bundle info [gemname]` to see where a bundled gem is installed.
   ```

   Note: Only supported under bundler enviroment at this moment 

1. Execute one of the example script,

   ```sh
   cd  glfw_opengl3
   r.bat              # Or double click glfw_opengl3.rbw in Windows explorer
                      # Ignore many warnings emmited in console window
   ```


#### Snapshots

---



##### ImGui-Toggle / CImGui-Toggle

---

[ImGui-Toggle](https://github.com/cmdwtf/imgui_toggle) / [CImGui-Toggle](https://github.com/dinau/cimgui_toggle)

[glfw_opengl3_imtoggle.rb](https://github.com/dinau/igruby_examples/blob/main/glfw_opengl3_imtoggle/glfw_opengl3_imtoggle.rb)  

![alt](https://github.com/dinau/igruby_examples/raw/main/img/imtoggle.png)  

##### ImDrawList party 

---

Reference to [ImDrawList coding party - deadline Nov 30, 2020! #3606](https://github.com/ocornut/imgui/issues/3606)

[glfw_opengl3_imdrawlistparty.rb](https://github.com/dinau/igruby_examples/blob/main/glfw_opengl3_imdrawlistparty/imDrawListParty.rb)  

![alt](https://github.com/dinau/igruby_examples/raw/main/img/imdrawlistparty.gif)  

##### ImGui-Knobs / CImGui-Knobs

---

[ImGui-Knobs](https://github.com/altschuler/imgui-knobs) / [CImGui-Knobs](https://github.com/dinau/cimgui-knobs)

[glfw_opengl3_imknobs.rb](glfw_opengl3_imknobs/glfw_opengl3_imknobs.rb)

![alt](img/imknobs.png)  

##### ImSpinner / CImSpinner

---

[ImSpinner](https://github.com/dalerank/imspinner) / [CImSpinner](https://github.com/dinau/cimspinner)

[glfw_opengl3_imspinner.rb](glfw_opengl3_imspinner/glfw_opengl3_imspinner.rb)  

Amazing !

![alt](img/imspinner.gif)


##### ImGuizmo / CImGuizmo

---

[ImGuizmo](https://github.com/CedricGuillemet/ImGuizmo) / [CImGuizmo](https://github.com/cimgui/cimguizmo)

[glfw_opengl3_imguizmo.rb](glfw_opengl3_imguizmo/glfw_opengl3_imguizmo.rb)  

![alt](img/imguizmo.png)

##### ImGuiColorTextEdit / cimCTE

---

[ImGuiColorTextEdit](https://github.com/santaclose/ImGuiColorTextEdit) / [cimCTE](https://github.com/cimgui/cimCTE) 

[glfw_opengl3_imcolortextedit.rb](https://github.com/dinau/igruby_examples/blob/main/glfw_opengl3_imcolortextedit/glfw_opengl3_imcolortextedit.rb)  

![alt](img/imcolortextedit.png)

##### ImNodes / CImNodes

---

[ImNodes](https://github.com/Nelarius/imnodes) / [CImNodes](https://github.com/cimgui/cimnodes)

[glfw_opengl3_imnodes.rb](https://github.com/dinau/igruby_examples/blob/main/glfw_opengl3_imnodes/glfw_opengl3_imnodes.rb)  

![alt](https://github.com/dinau/igruby_examples/raw/main/img/imnodes.png)

##### ImGuiFileDialog 

---

[ImGuiFileDialog](https://github.com/aiekick/ImGuiFileDialog)

[glfw_opengl3_imguifiledialog.rb](https://github.com/dinau/igruby_examples/blob/main/glfw_opengl3_imguifiledialog/glfw_opengl3_imguifiledialog.rb)  

![alt](https://github.com/dinau/igruby_examples/raw/main/img/imguifiledialog.png)

##### Iconfonts viewer

---

[glfw_opengl3_iconfont_viewer.rb](https://github.com/dinau/igruby_examples/blob/main/glfw_opengl3_iconfont_viewer/glfw_opengl3_iconfont_viewer.rb)

![alt](img/iconfont_viewer.png)

##### Image loading

---

[glfw_opengl3.rb](https://github.com/dinau/igruby_examples/blob/main/glfw_opengl3/glfw_opengl3.rb)

![alt](https://github.com/dinau/igruby_examples/raw/main/img/glfw_opengl3.gif)  

##### Showing CJK fonts

---

[glfw_opengl3_jp.rb](https://github.com/dinau/igruby_examples/blob/main/glfw_opengl3_jp/glfw_opengl3_jp.rb)

![alt](https://github.com/dinau/igruby_examples/raw/main/img/glfw_opengl3_jp.png)



#### For Linux x86_64

---
1. Install tools 

   ```sh
   $ sudo apt install clang git make ninja-build
   $ sudo apt install lib{opengl-dev,gl1-mesa-dev,glfw3,glfw3-dev,xcursor-dev,xinerama-dev,xi-dev}
   $ sudo apt install libsdl2-dev libsdl3-dev
   ```

1. Download files,

   ```sh
   $ pwd 
   my_dev_folder
   $ git clone --recursive https://github.com/dinau/ruby-imgui-dev
   $ git clone https://github.com/dinau/igruby_examples
   ```
   
      Folder structure,
   
      ```txt
      my_dev_folder
       |--- igruby_examples
       `--- ruby-imgui-dev
      ```

1. Generate imgui.so
   
   ```sh
   $ cd ruby-imgui-dev/imgui_dll
   $ make
   ```

   `imgui.so` file is generated in `ruby-imgui-dev/lib`
   
1. Install bundler

   ```sh
   $ sudo apt install ruby-dev gcc
   $ gem install --user-install bundler
   ```

1. Set environment variable,

   ```sh
   export GEM_HOME =~/.local/share/gem/ruby/3.3.0/bin
   ```

   Part of the `3.3.0` depends on your system.

1. Execute `bundle install`

   ```sh
   $ pwd 
   igruby_examples

   $ bundle install

   Fetching gem metadata from https://rubygems.org/..
   Resolving dependencies...
   Installing fiddle 1.1.8 with native extensions
   Fetching opengl-bindings2 2.0.4
   Installing opengl-bindings2 2.0.4
   Bundle complete! 6 Gemfile dependencies, 9 gems now installed.
   Use `bundle info [gemname]` to see where a bundled gem is installed.
   ```

1. Execute a example

   ```sh
   $ cd glfw_opengl3
   $ sh r.sh 
   ```

   or 
   
   `$ chmod +x glfw_opengl3.rbw`  
   then double click `glfw_opengl3.rbw` in your file explorer 

   or

   `$ bundle exec ruby glfw_opengl3.rb` on your console
