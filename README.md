# RT

Ray-Tracing project - visualization from scratch on C and Swift/Metal

## Build
```
git clone https://github.com/AlexeyBukin/RT_metal.git
cd RT_metal
git submodule update --init --recursive
make
```

## Sources

Directory ```src/``` contains only one file - main.c

#### (```./src/err/```)  Error handling
Error handling here

#### (```./src/fio/```) File I/O 
This module let us load and save .rts scene files

#### (```./src/gui/```) Graphical User Interface
This module let us process user input and show some interface

#### (```./src/mtl/```)  Metal
Ray-tracing code and GPU computing (shaders) here

#### (```./src/rtc/```)  RT Core
Core 'glue' code here
