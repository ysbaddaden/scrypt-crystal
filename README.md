# scrypt (crystal)

Crystal bindings for Colin Perceval's scrypt library.

The scrypt key derivation function was originally developed for use in the
Tarsnap online backup system and is designed to be far more secure against
hardware brute-force attacks than alternative functions such as PBKDF2 or
bcrypt.

- http://www.tarsnap.com/scrypt.html

## Install

Using [Shards](https:/github.com/ysbaddaden/shards), add the scrypt dependency
to your `shard.yml` then run `shards install`.

```yaml
dependencies:
  scrypt:
    github: ysbaddaden/scrypt-crystal
```

If you're not using Shards, you may clone the repository then run `make lib` to
download and compile the `libscrypt.a` library.

## Usage

```crystal
require "scrypt"

# hash
hashed_password = Scrypt::Password.create("super awesome")

# compare
hashed_password == "super awesome"  # => true
hashed_password == "super wrong"    # => false
```

## Authors

- Julien Portalier <julien@portalier.com>

## License

Distributed under the [BSD 2-Clause](https://opensource.org/licenses/BSD-2-Clause)
license.
