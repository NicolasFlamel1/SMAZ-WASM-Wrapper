# Library parameters
NAME = "SMAZ"
VERSION = "0.0.1"
CC = "em++"
CFLAGS = -Wall -Wno-writable-strings -D NDEBUG -Oz -finput-charset=UTF-8 -fexec-charset=UTF-8 -funsigned-char -ffunction-sections -fdata-sections -D VERSION=$(VERSION) -I smaz-master/ -s MODULARIZE=1 --memory-init-file=0 -s ABORTING_MALLOC=0 -s ALLOW_MEMORY_GROWTH=1 --closure 1 -s ENVIRONMENT=web -flto -fno-rtti -fno-exceptions -s NO_FILESYSTEM=1 -s DISABLE_EXCEPTION_CATCHING=1 -s EXPORTED_FUNCTIONS="['_malloc', '_free']" -s EXPORT_NAME="smaz"
LIBS =
SRCS = "main.cpp" "smaz-master/smaz.c"
PROGRAM_NAME = $(subst $\",,$(NAME))

# Make WASM
wasm:
	$(CC) $(CFLAGS) -s WASM=1 -o "./$(PROGRAM_NAME).js" $(SRCS) $(LIBS)
	cat "./main.js" >> "./$(PROGRAM_NAME).js"
	rm -rf "./dist"
	mkdir "./dist"
	mv "./$(PROGRAM_NAME).js" "./$(PROGRAM_NAME).wasm" "./dist/"

# Make asm.js
asmjs:
	$(CC) $(CFLAGS) -s WASM=0 -o "./$(PROGRAM_NAME).js" $(SRCS) $(LIBS)
	cat "./main.js" >> "./$(PROGRAM_NAME).js"
	rm -rf "./dist"
	mkdir "./dist"
	mv "./$(PROGRAM_NAME).js" "./dist/"

# Make clean
clean:
	rm -rf "./$(PROGRAM_NAME).js" "./$(PROGRAM_NAME).wasm" "./dist" "./smaz-master" "./master.zip"

# Make dependencies
dependencies:
	wget "https://github.com/antirez/smaz/archive/master.zip"
	unzip "./master.zip"
	rm "./master.zip"
