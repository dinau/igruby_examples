# Refer to:
#   OpenGLでの描画内容の画像化と保存(2012-11-07)
#     https://npal-shared.hatenablog.com/entry/20121107/1352284053

#-------------
# saveImage()
#-------------
RGB = 3
def saveImage(fname, xs, ys, _width, _height, comp = RGB, quality = 90)
  # Image size must be 2*n
  imageWidth = (width div 2) * 2
  imageHeight = (height div 2) * 2
  unless comp == RGB
    puts 'Error!: Color component numbers must be 3 (RGB) at saveImage.nim'
    return
  end
  if 1 > imageWidth or 1 > imageHeight
    echo 'Error!: Rect of save image is mismatch at saveImage.nim'
    return
  end

  # texBuffer =  newSeq[GLuByte](imageWidth * imageHeight * comp)
  # dataBuffer = newSeq[GLuByte](imageWidth * imageHeight * comp)
  dataBuffer = FFI::MemoryPointer.new(:GLuByte, imageWidth * imageHeight * comp)

  GL.ReadBuffer(GL.BACK)
  GL.ReadPixels(xs, ys,
                imageWidth, imageHeight,
                GL.RGB,
                GL.UNSIGNED_BYTE,
                dataBuffer)

  # Set upside-down
  # let widthStep = 3 * imageWidth
  # var n = 0
  # for y in 0..<imageHeight:
  #   for x in 0..<imageWidth:
  #     dataBuffer[ ( imageHeight - y - 1 ) * widthStep + (x * 3) + 0 ] = texBuffer[n + 0] # copy R
  #     dataBuffer[ ( imageHeight - y - 1 ) * widthStep + (x * 3) + 1 ] = texBuffer[n + 1] # copy G
  #     dataBuffer[ ( imageHeight - y - 1 ) * widthStep + (x * 3) + 2 ] = texBuffer[n + 2] # copy B
  #     inc(n,3)

  # Save image
  (_, _, ext) = fname.splitfile
  res = false
  case ext.toLowerAscii
  when '.jpg', '.jpeg'
    # JPEG quality is 90% default. quality=1..100
    res = stbiw.writeJPG(fname, imageWidth, imageHeight, comp, dataBuffer, quality)
  when '.png'
    res = stbiw.writePNG(fname, imageWidth, imageHeight, comp, dataBuffer)
  when '.bmp'
    res = stbiw.writeBMP(fname, imageWidth, imageHeight, comp, dataBuffer)
  when '.tga'
    # if quality == 0 then useRLE == false.
    res = stbiw.writeTGA(fname, imageWidth, imageHeight, comp, dataBuffer, (quality > 0))
  else
    echo 'Error! Unrecognize image extension: [', ext, ']'
    res = false
  end
  return if res

  puts 'Error!: at stbiw.writeNNN() function in saveImage.nim'
end
