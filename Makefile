.POSIX:

CRYSTAL=crystal

all: ext/libscrypt.a

ext/libscrypt.a:
	cd ext && make

clean: .phony
	cd ext && make clean

test: .phony
	$(CRYSTAL) run test/*_test.cr -- --verbose

.phony:
