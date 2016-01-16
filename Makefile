.PHONY: test

all: src/ext/libscrypt.a

src/ext/libscrypt.a:
	cd src/ext && make

clean:
	cd src/ext && make clean

test:
	crystal test/*_test.cr -- --verbose
