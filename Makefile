.PHONY: test

all: ext/libscrypt.a

ext/libscrypt.a:
	cd ext && make

clean:
	cd ext && make clean

test:
	crystal test/*_test.cr -- --verbose
