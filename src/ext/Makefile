SOURCES = $(wildcard *.c)
OBJECTS = $(patsubst %.c, %.o, $(SOURCES))
CFLAGS = -DHAVE_CONFIG_H -MD -MP -MF

all: libscrypt.a

libscrypt.a: $(OBJECTS)
	ar cru libscrypt.a $(OBJECTS)
	ranlib libscrypt.a

%.o: %.c
	$(CC) -g -O2 -c -o $@ $<

.PHONY: clean
clean:
	rm -f $(OBJECTS) libscrypt.a

