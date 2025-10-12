#!/usr/bin/env ruby
 require "pathname"

 # Gemfile.lock ��1��ɂ���ꍇ�̂� Bundler ��L����
 lockfile = Pathname.new(__dir__).parent.join("Gemfile.lock")
 require "bundler/setup" if lockfile.file?

# # �t�H���_���Ɠ����� rb �t�@�C���� require
 require File.join(__dir__, "#{File.basename(__dir__)}.rb")

#------
# main
#------
 main()
