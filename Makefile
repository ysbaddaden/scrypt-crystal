lib: tmp/scrypt-1.2.0
	touch src/ext/scrypt_platform.h
	cp tmp/scrypt-1.2.0/lib/crypto/crypto_scrypt.c src/ext
	cp tmp/scrypt-1.2.0/lib/crypto/crypto_scrypt.h src/ext
	cp tmp/scrypt-1.2.0/lib/crypto/crypto_scrypt_smix.c src/ext
	cp tmp/scrypt-1.2.0/lib/crypto/crypto_scrypt_smix.h src/ext
	cp tmp/scrypt-1.2.0/lib/crypto/crypto_scrypt_smix_sse2.c src/ext
	cp tmp/scrypt-1.2.0/lib/crypto/crypto_scrypt_smix_sse2.h src/ext
	cp tmp/scrypt-1.2.0/lib/scryptenc/scryptenc_cpuperf.c src/ext
	cp tmp/scrypt-1.2.0/lib/scryptenc/scryptenc_cpuperf.h src/ext
	cp tmp/scrypt-1.2.0/lib/util/memlimit.c src/ext
	cp tmp/scrypt-1.2.0/lib/util/memlimit.h src/ext
	cp tmp/scrypt-1.2.0/libcperciva/alg/sha256.c src/ext
	cp tmp/scrypt-1.2.0/libcperciva/alg/sha256.h src/ext
	cp tmp/scrypt-1.2.0/libcperciva/cpusupport/cpusupport_*.c src/ext
	cp tmp/scrypt-1.2.0/libcperciva/cpusupport/cpusupport.h src/ext
	cp tmp/scrypt-1.2.0/libcperciva/util/insecure_memzero.c src/ext
	cp tmp/scrypt-1.2.0/libcperciva/util/insecure_memzero.h src/ext
	cp tmp/scrypt-1.2.0/libcperciva/util/sysendian.h src/ext
	cp tmp/scrypt-1.2.0/libcperciva/util/warnp.c src/ext
	cp tmp/scrypt-1.2.0/libcperciva/util/warnp.h src/ext
	cd src/ext && make

clean:
	cd src/ext && make clean

tmp/scrypt-1.2.0: tmp/scrypt-1.2.0.tgz
	cd tmp && tar zxf scrypt-1.2.0.tgz

tmp/scrypt-1.2.0.tgz:
	mkdir -p tmp
	cd tmp && wget http://www.tarsnap.com/scrypt/scrypt-1.2.0.tgz

.PHONY: test
test:
	crystal test/*_test.cr -- --verbose
