AS := f64-as
EMU := f64-emu

BIOS := firmware/bios/main.asm
BIOS_BIN := bin/bios.bin

all: $(BIOS_BIN)

$(BIOS_BIN): $(BIOS) | bin
	cd firmware/bios && $(AS) main.asm ../../$(BIOS_BIN)

bin:
	mkdir -p bin

.PHONY: all clean test-bios
clean:
	rm -f bin/bios.bin

test-bios: $(BIOS_BIN)
	$(EMU) $(BIOS_BIN)
