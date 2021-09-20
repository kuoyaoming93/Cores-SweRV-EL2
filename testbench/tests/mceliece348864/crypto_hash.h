/* This file uses SHAKE256 implemented in the Keccak Code Package */

#include "fips202.h"

#define crypto_hash_32b(out,in,inlen) \
  shake256(out,32,in,inlen)

#define shake(out,outlen,in,inlen) \
  shake256(out,outlen,in,inlen)

