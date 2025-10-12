#!/usr/bin/env ruby
require "pathname"

# Gemfile.lock が1つ上にある場合のみ Bundler を有効化
lockfile = Pathname.new(__dir__).parent.join("Gemfile.lock")
require "bundler/setup" if lockfile.file?

# # フォルダ名と同名の rb ファイルを require
require File.join(__dir__, "#{File.basename(__dir__)}.rb")

#------
# main
#------
 main()
