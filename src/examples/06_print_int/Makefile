TARGET = print_int
AS = nasm

UNAME := $(shell uname)

ifeq ($(UNAME), Darwin)
	ASFLAGS = -f macho64 -F dwarf -g
	LD = ld -macosx_version_min 10.7.0 -lSystem -e start
else ifeq ($(UNAME), Linux)
	ASFLAGS = -f elf64 -F dwarf -g
	LD = ld -e start
else
	ERROR := ERROR: Platform "$(UNAME)" is not supported
endif

all: before clean $(TARGET)

before:
ifdef ERROR
	$(error $(ERROR))
else
	@echo Platform: "$(UNAME)"
endif

$(TARGET): $(TARGET).o
	@echo "\nLinking..."
	$(LD) -o $@_app $^
	@echo "\nOutput: $@_app"

%.o: %.asm
	@echo "\nCompiling..."
	$(AS) $(ASFLAGS) -o $@ $^

clean:
	@echo "\nCleaning..."
	rm -f *_app *.o

run:
	./$(TARGET)_app $(filter-out $@,$(MAKECMDGOALS))
%:
	@:

.PHONY: clean before run
