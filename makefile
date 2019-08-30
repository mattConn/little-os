loader.o: loader.s
	nasm -f elf32 $^

kernel.elf: link.ld
	ld -T $^ -melf_i386 loader.o -o $@

os.iso: menu.lst kernel.elf
	cp kernel.elf iso/boot; genisoimage -R -b boot/grub/stage2_eltorito -no-emul-boot -boot-load-size 4 -A os -input-charset utf8 -quiet -boot-info-table -o $@ iso;

all: loader.o kernel.elf os.iso

check:
	bochs

clean:
	rm *.o; rm *.iso; rm *.elf; rm iso/boot/kernel.elf;
