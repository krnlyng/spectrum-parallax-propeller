
SRC=fatfs.ifdefdspin speccy.ifdefdspin spi_warp.ifdefdspin qz80.ifdefdspin Speccy_Keyboard.ifdefdspin vgaSpeccy.ifdefdspin

DEFINES=-Dscreen=screen -DDracBladeProp

build: speccy.spin $(subst .ifdefdspin,.spin,$(SRC))
	bstc -b speccy.spin

clean:
	rm -rf *.spin
	rm -rf speccy.binary

%.spin: %.ifdefdspin $(SRC)
	sed -i 's/elseifdef \(.*\)/elif defined(\1)/g' *.ifdefdspin
	cpp -C $(DEFINES) -E -o $@ $<
	sed -i 's/^#.*//g' $@
	tail -n +50 $@ > $@.tmp
	mv $@.tmp $@

