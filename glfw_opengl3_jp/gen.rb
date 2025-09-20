require_relative '../genCommon.rb'

target =  File.basename(__dir__)

opts = ["--windows",
        "--icon res/r.ico",
       #"--debug-extract",
       #"--debug",
       #"--no-lzma",
       "img/himeji-400.jpg",
       "res/r.png",
]

aibika(target, opts)
