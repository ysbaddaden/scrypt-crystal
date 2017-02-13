VERSION ?= 1.2.1
SCRYPT = scrypt-$(VERSION)

SOURCES = $(wildcard *.c)
OBJECTS = $(patsubst %.c, %.o, $(SOURCES))
CFLAGS = -DHAVE_CONFIG_H -MD -MP -MF

all: $(SCRYPT) libscrypt.a

libscrypt.a: $(OBJECTS)
	ar cru libscrypt.a $(OBJECTS)
	ranlib libscrypt.a

%.o: %.c
	$(CC) -g -O2 -c -o $@ $<

$(SCRYPT):
	curl -L http://www.tarsnap.com/scrypt/$(SCRYPT).tgz | tar xz
	cp $(SCRYPT)/lib/crypto/crypto_scrypt.c .
	cp $(SCRYPT)/lib/crypto/crypto_scrypt.h .
	cp $(SCRYPT)/lib/crypto/crypto_scrypt_smix.c .
	cp $(SCRYPT)/lib/crypto/crypto_scrypt_smix.h .
	cp $(SCRYPT)/lib/crypto/crypto_scrypt_smix_sse2.c .
	cp $(SCRYPT)/lib/crypto/crypto_scrypt_smix_sse2.h .
	cp $(SCRYPT)/lib/scryptenc/scryptenc_cpuperf.c .
	cp $(SCRYPT)/lib/scryptenc/scryptenc_cpuperf.h .
	cp $(SCRYPT)/lib/util/memlimit.c .
	cp $(SCRYPT)/lib/util/memlimit.h .
	cp $(SCRYPT)/libcperciva/alg/sha256.c .
	cp $(SCRYPT)/libcperciva/alg/sha256.h .
	cp $(SCRYPT)/libcperciva/cpusupport/cpusupport_*.c .
	cp $(SCRYPT)/libcperciva/cpusupport/cpusupport.h .
	cp $(SCRYPT)/libcperciva/util/insecure_memzero.c .
	cp $(SCRYPT)/libcperciva/util/insecure_memzero.h .
	cp $(SCRYPT)/libcperciva/util/sysendian.h .
	cp $(SCRYPT)/libcperciva/util/warnp.c .
	cp $(SCRYPT)/libcperciva/util/warnp.h .
	touch scrypt_platform.h
	make libscrypt.a

clean:
	rm -rf $(SCRYPT) *.c *.h *.o *.a
