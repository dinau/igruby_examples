#--------
# aibika
#--------
def aibika(exeName, options)
  addedFiles = ["../dlls/glfw3.dll",
                "../utils/fonticon/fa6/fa-solid-900.ttf",
                "../utils/r.png"
               ]
  cmdTable =["aibika", exeName + ".rb", options.join(" ") , addedFiles.join(" ")]

  system(cmdTable.join(" "))
end
