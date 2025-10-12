require 'ffi'

# int型（更新されたひな型）
class FFIint
  def initialize(*val)
    @value = FFI::MemoryPointer.new(:int)
    val.size == 1 ? @value.write_int(val[0]) : @value.write_int(0)
  end

  def addr
    @value
  end

  def set(val)
    @value.write(:int, val[0])
  end

  def read
    @value.read_int
  end
end

# char型（8ビット符号付き整数）
class FFIchar
  def initialize(*val)
    @value = FFI::MemoryPointer.new(:char)
    val.size == 1 ? @value.write_char(val.first) : @value.write_char(0)
  end

  def addr
    @value
  end

  def set(val)
    @value.write(:char, val)
  end

  def read
    @value.read_char
  end
end

# short型（16ビット符号付き整数）
class FFIshort
  def initialize(*val)
    @value = FFI::MemoryPointer.new(:short)
    val.size == 1 ? @value.write_short(val.first) : @value.write_short(0)
  end

  def addr
    @value
  end

  def set(val)
    @value.write(:short, val)
  end

  def read
    @value.read_short
  end
end

# long型（プラットフォーム依存、通常32ビットまたは64ビット符号付き整数）
class FFIlong
  def initialize(*val)
    @value = FFI::MemoryPointer.new(:long)
    val.size == 1 ? @value.write_long(val.first) : @value.write_long(0)
  end

  def addr
    @value
  end

  def set(val)
    @value.write(:long, val)
  end

  def read
    @value.read_long
  end
end

# int8型（8ビット符号付き整数）
class FFIint8
  def initialize(*val)
    @value = FFI::MemoryPointer.new(:int8)
    val.size == 1 ? @value.write_int8(val.first) : @value.write_int8(0)
  end

  def addr
    @value
  end

  def set(val)
    @value.write(:int8, val)
  end

  def read
    @value.read_int8
  end
end

# int16型（16ビット符号付き整数）
class FFIint16
  def initialize(*val)
    @value = FFI::MemoryPointer.new(:int16)
    val.size == 1 ? @value.write_int16(val.first) : @value.write_int16(0)
  end

  def addr
    @value
  end

  def set(val)
    @value.write(:int16, val)
  end

  def read
    @value.read_int16
  end
end

# int32型（32ビット符号付き整数）
class FFIint32
  def initialize(*val)
    @value = FFI::MemoryPointer.new(:int32)
    val.size == 1 ? @value.write_int32(val.first) : @value.write_int32(0)
  end

  def addr
    @value
  end

  def set(val)
    @value.write(:int32, val)
  end

  def read
    @value.read_int32
  end
end

# int64型（64ビット符号付き整数）
class FFIint64
  def initialize(*val)
    @value = FFI::MemoryPointer.new(:int64)
    val.size == 1 ? @value.write_int64(val.first) : @value.write_int64(0)
  end

  def addr
    @value
  end

  def set(val)
    @value.write(:int64, val)
  end

  def read
    @value.read_int64
  end
end

# uchar型（8ビット符号なし整数）
class FFIuchar
  def initialize(*val)
    @value = FFI::MemoryPointer.new(:uchar)
    val.size == 1 ? @value.write_uchar(val.first) : @value.write_uchar(0)
  end

  def addr
    @value
  end

  def set(val)
    @value.write(:uchar, val)
  end

  def read
    @value.read_uchar
  end
end

# ushort型（16ビット符号なし整数）
class FFIushort
  def initialize(*val)
    @value = FFI::MemoryPointer.new(:ushort)
    val.size == 1 ? @value.write_ushort(val.first) : @value.write_ushort(0)
  end

  def addr
    @value
  end

  def set(val)
    @value.write(:ushort, val)
  end

  def read
    @value.read_ushort
  end
end

# uint型（プラットフォーム依存、通常32ビット符号なし整数）
class FFIuint
  def initialize(*val)
    @value = FFI::MemoryPointer.new(:uint)
    val.size == 1 ? @value.write_uint(val.first) : @value.write_uint(0)
  end

  def addr
    @value
  end

  def set(val)
    @value.write(:uint, val)
  end

  def read
    @value.read_uint
  end
end

# ulong型（プラットフォーム依存、通常32ビットまたは64ビット符号なし整数）
class FFIulong
  def initialize(*val)
    @value = FFI::MemoryPointer.new(:ulong)
    val.size == 1 ? @value.write_ulong(val.first) : @value.write_ulong(0)
  end

  def addr
    @value
  end

  def set(val)
    @value.write(:ulong, val)
  end

  def read
    @value.read_ulong
  end
end

# uint8型（8ビット符号なし整数）
class FFIuint8
  def initialize(*val)
    @value = FFI::MemoryPointer.new(:uint8)
    val.size == 1 ? @value.write_uint8(val.first) : @value.write_uint8(0)
  end

  def addr
    @value
  end

  def set(val)
    @value.write(:uint8, val)
  end

  def read
    @value.read_uint8
  end
end

# uint16型（16ビット符号なし整数）
class FFIuint16
  def initialize(*val)
    @value = FFI::MemoryPointer.new(:uint16)
    val.size == 1 ? @value.write_uint16(val.first) : @value.write_uint16(0)
  end

  def addr
    @value
  end

  def set(val)
    @value.write(:uint16, val)
  end

  def read
    @value.read_uint16
  end
end

# uint32型（32ビット符号なし整数）
class FFIuint32
  def initialize(*val)
    @value = FFI::MemoryPointer.new(:uint32)
    val.size == 1 ? @value.write_uint32(val.first) : @value.write_uint32(0)
  end

  def addr
    @value
  end

  def set(val)
    @value.write(:uint32, val)
  end

  def read
    @value.read_uint32
  end
end

# uint64型（64ビット符号なし整数）
class FFIuint64
  def initialize(*val)
    @value = FFI::MemoryPointer.new(:uint64)
    val.size == 1 ? @value.write_uint64(val.first) : @value.write_uint64(0)
  end

  def addr
    @value
  end

  def set(val)
    @value.write(:uint64, val)
  end

  def read
    @value.read_uint64
  end
end

# float型（32ビット浮動小数点数）
class FFIfloat
  def initialize(*val)
    @value = FFI::MemoryPointer.new(:float)
    val.size == 1 ? @value.write_float(val.first) : @value.write_float(0.0)
  end

  def addr
    @value
  end

  def set(val)
    @value.write(:float, val)
  end

  def read
    @value.read_float
  end
end

# double型（64ビット浮動小数点数）
class FFIdouble
  def initialize(*val)
    @value = FFI::MemoryPointer.new(:double)
    val.size == 1 ? @value.write_double(val.first) : @value.write_double(0.0)
  end

  def addr
    @value
  end

  def set(val)
    @value.write(:double, val)
  end

  def read
    @value.read_double
  end
end

# bool型（真偽値）
class FFIbool
  def initialize(*val)
    @value = FFI::MemoryPointer.new(:bool)
    val.size == 1 ? @value.write(:bool, val.first) : @value.write(:bool, false)
  end

  def addr
    @value
  end

  def set(val)
    @value.write(:bool, val)
  end

  def read
    @value.read(:bool)
  end
end

# pointer型（ポインタ）
class FFIpointer
  def initialize(*val)
    @value = FFI::MemoryPointer.new(:pointer)
    if val.size == 1
      if val.first.is_a?(Integer)
        @value.write_pointer(FFI::Pointer.new(val.first)) # 整数からFFI::Pointerを生成
      else
        @value.write_pointer(val.first || nil) # FFI::Pointerまたはnil
      end
    else
      @value.write_pointer(nil)
    end
  end

  def addr
    @value
  end

  def set(val)
    if val.is_a?(Integer)
      @value.write(:pointer, FFI::Pointer.new(val))
    else
      @value.write(:pointer, val)
    end
  end

  def read
    @value.read_pointer
  end
end

# string型（null終端文字列）
class FFIstring
  def initialize(*val)
    if val.size == 1 && val.first.is_a?(String)
      @value = FFI::MemoryPointer.new(:char, val.first.bytesize + 1)
      @value.write_string(val.first)
    else
      @value = FFI::MemoryPointer.new(:char, 1)
      @value.write_string("")
    end
  end

  def addr
    @value
  end

  def set(val)
    raise ArgumentError, "Value must be a string" unless val.is_a?(String)
    @value.free if @value
    @value = FFI::MemoryPointer.new(:char, val.bytesize + 1)
    @value.write_string(val)
  end

  def read
    @value.read_string
  end
end

# int型配列
class FFIintArray
  def initialize(*val, size:)
    raise ArgumentError, "Size must be positive" unless size > 0
    @size = size
    @value = FFI::MemoryPointer.new(:int, size)
    if val.size == 1 && val.first.is_a?(Array)
      val.first.take(size).each_with_index { |v, i| @value[i].write_int(v) }
    else
      size.times { |i| @value[i].write_int(0) }
    end
  end

  def addr
    @value
  end

  def set(val, index = nil)
    if index.nil? && val.is_a?(Array)
      val.take(@size).each_with_index { |v, i| @value[i].write_int(v) }
    elsif index.is_a?(Integer) && (0...@size).include?(index)
      @value[index].write_int(val)
    else
      raise ArgumentError, "Invalid index or value. Index must be 0..#{@size-1} or use array."
    end
  end

  def read(index = nil)
    if index.nil?
      (0...@size).map { |i| @value[i].read_int }
    elsif (0...@size).include?(index)
      @value[index].read_int
    else
      raise ArgumentError, "Invalid index. Must be 0..#{@size-1}."
    end
  end
end

# char型配列
class FFIcharArray
  def initialize(*val, size:)
    raise ArgumentError, "Size must be positive" unless size > 0
    @size = size
    @value = FFI::MemoryPointer.new(:char, size)
    if val.size == 1 && val.first.is_a?(Array)
      val.first.take(size).each_with_index { |v, i| @value[i].write_char(v) }
    else
      size.times { |i| @value[i].write_char(0) }
    end
  end

  def addr
    @value
  end

  def set(val, index = nil)
    if index.nil? && val.is_a?(Array)
      val.take(@size).each_with_index { |v, i| @value[i].write_char(v) }
    elsif index.is_a?(Integer) && (0...@size).include?(index)
      @value[index].write_char(val)
    else
      raise ArgumentError, "Invalid index or value. Index must be 0..#{@size-1} or use array."
    end
  end

  def read(index = nil)
    if index.nil?
      (0...@size).map { |i| @value[i].read_char }
    elsif (0...@size).include?(index)
      @value[index].read_char
    else
      raise ArgumentError, "Invalid index. Must be 0..#{@size-1}."
    end
  end
end

# short型配列
class FFIshortArray
  def initialize(*val, size:)
    raise ArgumentError, "Size must be positive" unless size > 0
    @size = size
    @value = FFI::MemoryPointer.new(:short, size)
    if val.size == 1 && val.first.is_a?(Array)
      val.first.take(size).each_with_index { |v, i| @value[i].write_short(v) }
    else
      size.times { |i| @value[i].write_short(0) }
    end
  end

  def addr
    @value
  end

  def set(val, index = nil)
    if index.nil? && val.is_a?(Array)
      val.take(@size).each_with_index { |v, i| @value[i].write_short(v) }
    elsif index.is_a?(Integer) && (0...@size).include?(index)
      @value[index].write_short(val)
    else
      raise ArgumentError, "Invalid index or value. Index must be 0..#{@size-1} or use array."
    end
  end

  def read(index = nil)
    if index.nil?
      (0...@size).map { |i| @value[i].read_short }
    elsif (0...@size).include?(index)
      @value[index].read_short
    else
      raise ArgumentError, "Invalid index. Must be 0..#{@size-1}."
    end
  end
end

# long型配列
class FFIlongArray
  def initialize(*val, size:)
    raise ArgumentError, "Size must be positive" unless size > 0
    @size = size
    @value = FFI::MemoryPointer.new(:long, size)
    if val.size == 1 && val.first.is_a?(Array)
      val.first.take(size).each_with_index { |v, i| @value[i].write_long(v) }
    else
      size.times { |i| @value[i].write_long(0) }
    end
  end

  def addr
    @value
  end

  def set(val, index = nil)
    if index.nil? && val.is_a?(Array)
      val.take(@size).each_with_index { |v, i| @value[i].write_long(v) }
    elsif index.is_a?(Integer) && (0...@size).include?(index)
      @value[index].write_long(val)
    else
      raise ArgumentError, "Invalid index or value. Index must be 0..#{@size-1} or use array."
    end
  end

  def read(index = nil)
    if index.nil?
      (0...@size).map { |i| @value[i].read_long }
    elsif (0...@size).include?(index)
      @value[index].read_long
    else
      raise ArgumentError, "Invalid index. Must be 0..#{@size-1}."
    end
  end
end

# int8型配列
class FFIint8Array
  def initialize(*val, size:)
    raise ArgumentError, "Size must be positive" unless size > 0
    @size = size
    @value = FFI::MemoryPointer.new(:int8, size)
    if val.size == 1 && val.first.is_a?(Array)
      val.first.take(size).each_with_index { |v, i| @value[i].write_int8(v) }
    else
      size.times { |i| @value[i].write_int8(0) }
    end
  end

  def addr
    @value
  end

  def set(val, index = nil)
    if index.nil? && val.is_a?(Array)
      val.take(@size).each_with_index { |v, i| @value[i].write_int8(v) }
    elsif index.is_a?(Integer) && (0...@size).include?(index)
      @value[index].write_int8(val)
    else
      raise ArgumentError, "Invalid index or value. Index must be 0..#{@size-1} or use array."
    end
  end

  def read(index = nil)
    if index.nil?
      (0...@size).map { |i| @value[i].read_int8 }
    elsif (0...@size).include?(index)
      @value[index].read_int8
    else
      raise ArgumentError, "Invalid index. Must be 0..#{@size-1}."
    end
  end
end

# int16型配列
class FFIint16Array
  def initialize(*val, size:)
    raise ArgumentError, "Size must be positive" unless size > 0
    @size = size
    @value = FFI::MemoryPointer.new(:int16, size)
    if val.size == 1 && val.first.is_a?(Array)
      val.first.take(size).each_with_index { |v, i| @value[i].write_int16(v) }
    else
      size.times { |i| @value[i].write_int16(0) }
    end
  end

  def addr
    @value
  end

  def set(val, index = nil)
    if index.nil? && val.is_a?(Array)
      val.take(@size).each_with_index { |v, i| @value[i].write_int16(v) }
    elsif index.is_a?(Integer) && (0...@size).include?(index)
      @value[index].write_int16(val)
    else
      raise ArgumentError, "Invalid index or value. Index must be 0..#{@size-1} or use array."
    end
  end

  def read(index = nil)
    if index.nil?
      (0...@size).map { |i| @value[i].read_int16 }
    elsif (0...@size).include?(index)
      @value[index].read_int16
    else
      raise ArgumentError, "Invalid index. Must be 0..#{@size-1}."
    end
  end
end

# int32型配列
class FFIint32Array
  def initialize(*val, size:)
    raise ArgumentError, "Size must be positive" unless size > 0
    @size = size
    @value = FFI::MemoryPointer.new(:int32, size)
    if val.size == 1 && val.first.is_a?(Array)
      val.first.take(size).each_with_index { |v, i| @value[i].write_int32(v) }
    else
      size.times { |i| @value[i].write_int32(0) }
    end
  end

  def addr
    @value
  end

  def set(val, index = nil)
    if index.nil? && val.is_a?(Array)
      val.take(@size).each_with_index { |v, i| @value[i].write_int32(v) }
    elsif index.is_a?(Integer) && (0...@size).include?(index)
      @value[index].write_int32(val)
    else
      raise ArgumentError, "Invalid index or value. Index must be 0..#{@size-1} or use array."
    end
  end

  def read(index = nil)
    if index.nil?
      (0...@size).map { |i| @value[i].read_int32 }
    elsif (0...@size).include?(index)
      @value[index].read_int32
    else
      raise ArgumentError, "Invalid index. Must be 0..#{@size-1}."
    end
  end
end

# int64型配列
class FFIint64Array
  def initialize(*val, size:)
    raise ArgumentError, "Size must be positive" unless size > 0
    @size = size
    @value = FFI::MemoryPointer.new(:int64, size)
    if val.size == 1 && val.first.is_a?(Array)
      val.first.take(size).each_with_index { |v, i| @value[i].write_int64(v) }
    else
      size.times { |i| @value[i].write_int64(0) }
    end
  end

  def addr
    @value
  end

  def set(val, index = nil)
    if index.nil? && val.is_a?(Array)
      val.take(@size).each_with_index { |v, i| @value[i].write_int64(v) }
    elsif index.is_a?(Integer) && (0...@size).include?(index)
      @value[index].write_int64(val)
    else
      raise ArgumentError, "Invalid index or value. Index must be 0..#{@size-1} or use array."
    end
  end

  def read(index = nil)
    if index.nil?
      (0...@size).map { |i| @value[i].read_int64 }
    elsif (0...@size).include?(index)
      @value[index].read_int64
    else
      raise ArgumentError, "Invalid index. Must be 0..#{@size-1}."
    end
  end
end

# uchar型配列
class FFIucharArray
  def initialize(*val, size:)
    raise ArgumentError, "Size must be positive" unless size > 0
    @size = size
    @value = FFI::MemoryPointer.new(:uchar, size)
    if val.size == 1 && val.first.is_a?(Array)
      val.first.take(size).each_with_index { |v, i| @value[i].write_uchar(v) }
    else
      size.times { |i| @value[i].write_uchar(0) }
    end
  end

  def addr
    @value
  end

  def set(val, index = nil)
    if index.nil? && val.is_a?(Array)
      val.take(@size).each_with_index { |v, i| @value[i].write_uchar(v) }
    elsif index.is_a?(Integer) && (0...@size).include?(index)
      @value[index].write_uchar(val)
    else
      raise ArgumentError, "Invalid index or value. Index must be 0..#{@size-1} or use array."
    end
  end

  def read(index = nil)
    if index.nil?
      (0...@size).map { |i| @value[i].read_uchar }
    elsif (0...@size).include?(index)
      @value[index].read_uchar
    else
      raise ArgumentError, "Invalid index. Must be 0..#{@size-1}."
    end
  end
end

# ushort型配列
class FFIushortArray
  def initialize(*val, size:)
    raise ArgumentError, "Size must be positive" unless size > 0
    @size = size
    @value = FFI::MemoryPointer.new(:ushort, size)
    if val.size == 1 && val.first.is_a?(Array)
      val.first.take(size).each_with_index { |v, i| @value[i].write_ushort(v) }
    else
      size.times { |i| @value[i].write_ushort(0) }
    end
  end

  def addr
    @value
  end

  def set(val, index = nil)
    if index.nil? && val.is_a?(Array)
      val.take(@size).each_with_index { |v, i| @value[i].write_ushort(v) }
    elsif index.is_a?(Integer) && (0...@size).include?(index)
      @value[index].write_ushort(val)
    else
      raise ArgumentError, "Invalid index or value. Index must be 0..#{@size-1} or use array."
    end
  end

  def read(index = nil)
    if index.nil?
      (0...@size).map { |i| @value[i].read_ushort }
    elsif (0...@size).include?(index)
      @value[index].read_ushort
    else
      raise ArgumentError, "Invalid index. Must be 0..#{@size-1}."
    end
  end
end

# uint型配列
class FFIuintArray
  def initialize(*val, size:)
    raise ArgumentError, "Size must be positive" unless size > 0
    @size = size
    @value = FFI::MemoryPointer.new(:uint, size)
    if val.size == 1 && val.first.is_a?(Array)
      val.first.take(size).each_with_index { |v, i| @value[i].write_uint(v) }
    else
      size.times { |i| @value[i].write_uint(0) }
    end
  end

  def addr
    @value
  end

  def set(val, index = nil)
    if index.nil? && val.is_a?(Array)
      val.take(@size).each_with_index { |v, i| @value[i].write_uint(v) }
    elsif index.is_a?(Integer) && (0...@size).include?(index)
      @value[index].write_uint(val)
    else
      raise ArgumentError, "Invalid index or value. Index must be 0..#{@size-1} or use array."
    end
  end

  def read(index = nil)
    if index.nil?
      (0...@size).map { |i| @value[i].read_uint }
    elsif (0...@size).include?(index)
      @value[index].read_uint
    else
      raise ArgumentError, "Invalid index. Must be 0..#{@size-1}."
    end
  end
end

# ulong型配列
class FFIulongArray
  def initialize(*val, size:)
    raise ArgumentError, "Size must be positive" unless size > 0
    @size = size
    @value = FFI::MemoryPointer.new(:ulong, size)
    if val.size == 1 && val.first.is_a?(Array)
      val.first.take(size).each_with_index { |v, i| @value[i].write_ulong(v) }
    else
      size.times { |i| @value[i].write_ulong(0) }
    end
  end

  def addr
    @value
  end

  def set(val, index = nil)
    if index.nil? && val.is_a?(Array)
      val.take(@size).each_with_index { |v, i| @value[i].write_ulong(v) }
    elsif index.is_a?(Integer) && (0...@size).include?(index)
      @value[index].write_ulong(val)
    else
      raise ArgumentError, "Invalid index or value. Index must be 0..#{@size-1} or use array."
    end
  end

  def read(index = nil)
    if index.nil?
      (0...@size).map { |i| @value[i].read_ulong }
    elsif (0...@size).include?(index)
      @value[index].read_ulong
    else
      raise ArgumentError, "Invalid index. Must be 0..#{@size-1}."
    end
  end
end

# uint8型配列
class FFIuint8Array
  def initialize(*val, size:)
    raise ArgumentError, "Size must be positive" unless size > 0
    @size = size
    @value = FFI::MemoryPointer.new(:uint8, size)
    if val.size == 1 && val.first.is_a?(Array)
      val.first.take(size).each_with_index { |v, i| @value[i].write_uint8(v) }
    else
      size.times { |i| @value[i].write_uint8(0) }
    end
  end

  def addr
    @value
  end

  def set(val, index = nil)
    if index.nil? && val.is_a?(Array)
      val.take(@size).each_with_index { |v, i| @value[i].write_uint8(v) }
    elsif index.is_a?(Integer) && (0...@size).include?(index)
      @value[index].write_uint8(val)
    else
      raise ArgumentError, "Invalid index or value. Index must be 0..#{@size-1} or use array."
    end
  end

  def read(index = nil)
    if index.nil?
      (0...@size).map { |i| @value[i].read_uint8 }
    elsif (0...@size).include?(index)
      @value[index].read_uint8
    else
      raise ArgumentError, "Invalid index. Must be 0..#{@size-1}."
    end
  end
end

# uint16型配列
class FFIuint16Array
  def initialize(*val, size:)
    raise ArgumentError, "Size must be positive" unless size > 0
    @size = size
    @value = FFI::MemoryPointer.new(:uint16, size)
    if val.size == 1 && val.first.is_a?(Array)
      val.first.take(size).each_with_index { |v, i| @value[i].write_uint16(v) }
    else
      size.times { |i| @value[i].write_uint16(0) }
    end
  end

  def addr
    @value
  end

  def set(val, index = nil)
    if index.nil? && val.is_a?(Array)
      val.take(@size).each_with_index { |v, i| @value[i].write_uint16(v) }
    elsif index.is_a?(Integer) && (0...@size).include?(index)
      @value[index].write_uint16(val)
    else
      raise ArgumentError, "Invalid index or value. Index must be 0..#{@size-1} or use array."
    end
  end

  def read(index = nil)
    if index.nil?
      (0...@size).map { |i| @value[i].read_uint16 }
    elsif (0...@size).include?(index)
      @value[index].read_uint16
    else
      raise ArgumentError, "Invalid index. Must be 0..#{@size-1}."
    end
  end
end

# uint32型配列
class FFIuint32Array
  def initialize(*val, size:)
    raise ArgumentError, "Size must be positive" unless size > 0
    @size = size
    @value = FFI::MemoryPointer.new(:uint32, size)
    if val.size == 1 && val.first.is_a?(Array)
      val.first.take(size).each_with_index { |v, i| @value[i].write_uint32(v) }
    else
      size.times { |i| @value[i].write_uint32(0) }
    end
  end

  def addr
    @value
  end

  def set(val, index = nil)
    if index.nil? && val.is_a?(Array)
      val.take(@size).each_with_index { |v, i| @value[i].write_uint32(v) }
    elsif index.is_a?(Integer) && (0...@size).include?(index)
      @value[index].write_uint32(val)
    else
      raise ArgumentError, "Invalid index or value. Index must be 0..#{@size-1} or use array."
    end
  end

  def read(index = nil)
    if index.nil?
      (0...@size).map { |i| @value[i].read_uint32 }
    elsif (0...@size).include?(index)
      @value[index].read_uint32
    else
      raise ArgumentError, "Invalid index. Must be 0..#{@size-1}."
    end
  end
end

# uint64型配列
class FFIuint64Array
  def initialize(*val, size:)
    raise ArgumentError, "Size must be positive" unless size > 0
    @size = size
    @value = FFI::MemoryPointer.new(:uint64, size)
    if val.size == 1 && val.first.is_a?(Array)
      val.first.take(size).each_with_index { |v, i| @value[i].write_uint64(v) }
    else
      size.times { |i| @value[i].write_uint64(0) }
    end
  end

  def addr
    @value
  end

  def set(val, index = nil)
    if index.nil? && val.is_a?(Array)
      val.take(@size).each_with_index { |v, i| @value[i].write_uint64(v) }
    elsif index.is_a?(Integer) && (0...@size).include?(index)
      @value[index].write_uint64(val)
    else
      raise ArgumentError, "Invalid index or value. Index must be 0..#{@size-1} or use array."
    end
  end

  def read(index = nil)
    if index.nil?
      (0...@size).map { |i| @value[i].read_uint64 }
    elsif (0...@size).include?(index)
      @value[index].read_uint64
    else
      raise ArgumentError, "Invalid index. Must be 0..#{@size-1}."
    end
  end
end

# float型配列
class FFIfloatArray
  def initialize(*val, size:)
    raise ArgumentError, "Size must be positive" unless size > 0
    @size = size
    @value = FFI::MemoryPointer.new(:float, size)
    if val.size == 1 && val.first.is_a?(Array)
      val.first.take(size).each_with_index { |v, i| @value[i].write_float(v) }
    else
      size.times { |i| @value[i].write_float(0.0) }
    end
  end

  def addr
    @value
  end

  def set(val, index = nil)
    if index.nil? && val.is_a?(Array)
      val.take(@size).each_with_index { |v, i| @value[i].write_float(v) }
    elsif index.is_a?(Integer) && (0...@size).include?(index)
      @value[index].write_float(val)
    else
      raise ArgumentError, "Invalid index or value. Index must be 0..#{@size-1} or use array."
    end
  end

  def read(index = nil)
    if index.nil?
      (0...@size).map { |i| @value[i].read_float }
    elsif (0...@size).include?(index)
      @value[index].read_float
    else
      raise ArgumentError, "Invalid index. Must be 0..#{@size-1}."
    end
  end
end

# double型配列
class FFIdoubleArray
  def initialize(*val, size:)
    raise ArgumentError, "Size must be positive" unless size > 0
    @size = size
    @value = FFI::MemoryPointer.new(:double, size)
    if val.size == 1 && val.first.is_a?(Array)
      val.first.take(size).each_with_index { |v, i| @value[i].write_double(v) }
    else
      size.times { |i| @value[i].write_double(0.0) }
    end
  end

  def addr
    @value
  end

  def set(val, index = nil)
    if index.nil? && val.is_a?(Array)
      val.take(@size).each_with_index { |v, i| @value[i].write_double(v) }
    elsif index.is_a?(Integer) && (0...@size).include?(index)
      @value[index].write_double(val)
    else
      raise ArgumentError, "Invalid index or value. Index must be 0..#{@size-1} or use array."
    end
  end

  def read(index = nil)
    if index.nil?
      (0...@size).map { |i| @value[i].read_double }
    elsif (0...@size).include?(index)
      @value[index].read_double
    else
      raise ArgumentError, "Invalid index. Must be 0..#{@size-1}."
    end
  end
end

# bool型配列
class FFIboolArray
  def initialize(*val, size:)
    raise ArgumentError, "Size must be positive" unless size > 0
    @size = size
    @value = FFI::MemoryPointer.new(:bool, size)
    if val.size == 1 && val.first.is_a?(Array)
      val.first.take(size).each_with_index { |v, i| @value[i].write(:bool, v) }
    else
      size.times { |i| @value[i].write(:bool, false) }
    end
  end

  def addr
    @value
  end

  def set(val, index = nil)
    if index.nil? && val.is_a?(Array)
      val.take(@size).each_with_index { |v, i| @value[i].write(:bool, v) }
    elsif index.is_a?(Integer) && (0...@size).include?(index)
      @value[index].write(:bool, val)
    else
      raise ArgumentError, "Invalid index or value. Index must be 0..#{@size-1} or use array."
    end
  end

  def read(index = nil)
    if index.nil?
      (0...@size).map { |i| @value[i].read(:bool) }
    elsif (0...@size).include?(index)
      @value[index].read(:bool)
    else
      raise ArgumentError, "Invalid index. Must be 0..#{@size-1}."
    end
  end
end

# pointer型配列
class FFIpointerArray
  def initialize(*val, size:)
    raise ArgumentError, "Size must be positive" unless size > 0
    @size = size
    @value = FFI::MemoryPointer.new(:pointer, size)
    if val.size == 1 && val.first.is_a?(Array)
      val.first.take(size).each_with_index { |v, i| @value[i].write_pointer(v) }
    else
      size.times { |i| @value[i].write_pointer(nil) }
    end
  end

  def addr
    @value
  end

  def set(val, index = nil)
    if index.nil? && val.is_a?(Array)
      val.take(@size).each_with_index { |v, i| @value[i].write_pointer(v) }
    elsif index.is_a?(Integer) && (0...@size).include?(index)
      @value[index].write_pointer(val)
    else
      raise ArgumentError, "Invalid index or value. Index must be 0..#{@size-1} or use array."
    end
  end

  def read(index = nil)
    if index.nil?
      (0...@size).map { |i| @value[i].read_pointer }
    elsif (0...@size).include?(index)
      @value[index].read_pointer
    else
      raise ArgumentError, "Invalid index. Must be 0..#{@size-1}."
    end
  end
end

# string型配列（各要素がnull終端文字列）
class FFIstringArray
  def initialize(*val, size:)
    raise ArgumentError, "Size must be positive" unless size > 0
    @size = size
    @value = FFI::MemoryPointer.new(:pointer, size) # ポインタの配列
    @strings = []
    if val.size == 1 && val.first.is_a?(Array)
      val.first.take(size).each_with_index do |v, i|
        raise ArgumentError, "Value must be a string" unless v.is_a?(String)
        str_ptr = FFI::MemoryPointer.new(:char, v.bytesize + 1)
        str_ptr.write_string(v)
        @value[i].write_pointer(str_ptr)
        @strings[i] = str_ptr
      end
      (val.first.size...size).each { |i| @value[i].write_pointer(nil); @strings[i] = nil }
    else
      size.times { |i| @value[i].write_pointer(nil); @strings[i] = nil }
    end
  end

  def addr
    @value
  end

  def set(val, index = nil)
    if index.nil? && val.is_a?(Array)
      val.take(@size).each_with_index do |v, i|
        raise ArgumentError, "Value must be a string" unless v.is_a?(String)
        str_ptr = FFI::MemoryPointer.new(:char, v.bytesize + 1)
        str_ptr.write_string(v)
        @value[i].write_pointer(str_ptr)
        @strings[i]&.free
        @strings[i] = str_ptr
      end
    elsif index.is_a?(Integer) && (0...@size).include?(index)
      raise ArgumentError, "Value must be a string" unless val.is_a?(String)
      str_ptr = FFI::MemoryPointer.new(:char, val.bytesize + 1)
      str_ptr.write_string(val)
      @value[index].write_pointer(str_ptr)
      @strings[index]&.free
      @strings[index] = str_ptr
    else
      raise ArgumentError, "Invalid index or value. Index must be 0..#{@size-1} or use array of strings."
    end
  end

  def read(index = nil)
    if index.nil?
      (0...@size).map do |i|
        ptr = @value[i].read_pointer
        ptr.null? ? nil : ptr.read_string
      end
    elsif (0...@size).include?(index)
      ptr = @value[index].read_pointer
      ptr.null? ? nil : ptr.read_string
    else
      raise ArgumentError, "Invalid index. Must be 0..#{@size-1}."
    end
  end
end
