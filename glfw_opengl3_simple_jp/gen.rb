require_relative '../genCommon.rb'

target =  File.basename(__dir__)

opts = ["--windows",
        "--icon res/r.ico",
       #"--debug-extract",
       #"--debug",
       #"--no-lzma",
       "res/r.png",
]

aibika(target, opts)
