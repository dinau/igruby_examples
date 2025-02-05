# 2025/02 by audin
#
require 'stbimage'

STBIMAGE.load_lib()

#---------------------
# LoadTextureFromFile
#---------------------
def LoadTextureFromFile(filename, outTexture, outWidth, outHeight)
  if not File.exist? filename then
    print "\nError!: Image file not found  error:  ", filename
    return false
  end
  channels =  ' ' * 4
  image_data = STBIMAGE.stbi_load(filename, outWidth, outHeight, channels, 4)
  #print "\nchannels = [#{channels.unpack1('L')}]"

  # Create a OpenGL texture identifier
  GL.GenTextures(1, outTexture)
  GL.BindTexture(GL::TEXTURE_2D, outTexture.unpack1('L'))
  # Setup filtering parameters for display
  GL.TexParameteri(GL::TEXTURE_2D, GL::TEXTURE_MIN_FILTER, GL::LINEAR)
  GL.TexParameteri(GL::TEXTURE_2D, GL::TEXTURE_MAG_FILTER, GL::LINEAR)
  # This is required on WebGL for non power-of-two textures
  GL.TexParameteri(GL::TEXTURE_2D, GL::TEXTURE_WRAP_S, GL::CLAMP_TO_EDGE)
  GL.TexParameteri(GL::TEXTURE_2D, GL::TEXTURE_WRAP_T, GL::CLAMP_TO_EDGE)

  # Upload pixels into texture
  #if defined(GL_UNPACK_ROW_LENGTH) && !defined(__EMSCRIPTEN__)
  # TODO
  GL.PixelStorei(GL::UNPACK_ROW_LENGTH, 0)
  #endif
  GL.TexImage2D(GL::TEXTURE_2D, 0, GL::RGBA , outWidth.unpack1('L'), outHeight.unpack1('L'), 0, GL::RGBA, GL::UNSIGNED_BYTE, image_data)
  return true
end

#-------------------------------------
# Load title bar icon for GLFW window
#-------------------------------------
def LoadTitleBarIcon(window, iconName)
  if File.exist? iconName then
    w = ' ' * 4
    h = ' ' * 4
    channels =  ' ' * 4
    pixels = STBIMAGE.stbi_load(iconName, w, h, channels, 0)
    channels = channels.unpack1('L')
    #print "\nchannels = [#{channels}]"
    img = GLFW::GLFWimage.malloc
    img.width  = w.unpack1('L')
    img.height = h.unpack1('L')
    img.pixels = pixels
    GLFW.SetWindowIcon(window, 1, img)
    STBIMAGE.stbi_image_free(pixels)
  else
    print "\nNot found: #{iconName}"
    GLFW.SetWindowIcon(window, 0, nil)
  end
end
