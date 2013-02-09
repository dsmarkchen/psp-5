all: 
	mkdir -p build
	cd gtest; make all
	cd source; make all

clean: 
	cd gtest; make clean
	cd source; make clean
