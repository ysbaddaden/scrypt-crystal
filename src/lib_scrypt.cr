@[Link(ldflags: "-L#{__DIR__}/ext -lscrypt")]
lib LibScrypt
  fun crypto_scrypt(
    passwd : UInt8*,
    passwdlen : LibC::SizeT,
    salt : UInt8*,
    saltlen : LibC::SizeT,
    n : UInt64,
    r : UInt32,
    p : UInt32,
    buf : UInt8*,
    buflen : LibC::SizeT
  ) : LibC::Int

  fun memtouse(max_mem : LibC::SizeT, max_memfrac : LibC::Double, memlimit : LibC::SizeT*) : LibC::Int
  fun scryptenc_cpuperf(opps : LibC::Double*) : LibC::Int
end
