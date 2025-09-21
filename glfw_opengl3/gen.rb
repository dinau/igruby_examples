<<<<<<< HEAD
require_relative '../genCommon.rb'

target =  File.basename(__dir__)

opts = ["--windows",
        "--icon res/r.ico",
       #"--debug-extract",
       #"--debug",
       #"--no-lzma",
       "img/museum-400.png",
       "res/r.png",
]

aibika(target, opts)
||||||| c44ce0a
=======
require_relative '../genCommon.rb'

target =  File.basename(__dir__)

opts = ["--windows",
        "--icon res/r.ico",
       "--debug-extract",
       "--debug",
       "--no-lzma",
       "img/museum-400.png",
       "res/r.png",
]

aibika(target, opts)
>>>>>>> new_driver
