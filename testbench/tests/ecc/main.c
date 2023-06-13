/* 

  Crypto using elliptic curves defined over the finite binary field GF(2^m) where m is prime.

  The curves used are the anomalous binary curves (ABC-curves) or also called Koblitz curves.

  This class of curves was chosen because it yields efficient implementation of operations.



  Curves available - their different NIST/SECG names and eqivalent symmetric security level:

      NIST      SEC Group     strength
    ------------------------------------
      K-163     sect163k1      80 bit
      B-163     sect163r2      80 bit
      K-233     sect233k1     112 bit
      B-233     sect233r1     112 bit
      K-283     sect283k1     128 bit
      B-283     sect283r1     128 bit
      K-409     sect409k1     192 bit
      B-409     sect409r1     192 bit
      K-571     sect571k1     256 bit
      B-571     sect571r1     256 bit



  Curve parameters from:

    http://www.secg.org/sec2-v2.pdf
    http://csrc.nist.gov/publications/fips/fips186-3/fips_186-3.pdf


  Reference:

    https://www.ietf.org/rfc/rfc4492.txt 
*/

#include <stdio.h>
#include <stdint.h>
#include "ecdh.h"


/* margin for overhead needed in intermediate calculations */
#define BITVEC_MARGIN     3
#define BITVEC_NBITS      (CURVE_DEGREE + BITVEC_MARGIN)
#define BITVEC_NWORDS     ((BITVEC_NBITS + 31) / 32)
#define BITVEC_NBYTES     (sizeof(uint32_t) * BITVEC_NWORDS)


/* Disable //assertions? */
#ifndef DISABLE_assert
 #define DISABLE_assert 0
#endif

#if defined(DISABLE_assert) && (DISABLE_assert == 1)
 #define assert(...)
#else
 #include <assert.h>
#endif

/* Default to a (somewhat) constant-time mode?
   NOTE: The library is _not_ capable of operating in constant-time and leaks information via timing.
         Even if all operations are written const-time-style, it requires the hardware is able to multiply in constant time. 
         Multiplication on ARM Cortex-M processors takes a variable number of cycles depending on the operands...
*/
#ifndef CONST_TIME
  #define CONST_TIME 1
#endif

/* Default to using ECC_CDH (cofactor multiplication-variation) ? */
#ifndef ECDH_COFACTOR_VARIANT
  #define ECDH_COFACTOR_VARIANT 0
#endif

/******************************************************************************/


/* the following type will represent bit vectors of length (CURVE_DEGREE+MARGIN) */
typedef uint32_t bitvec_t[BITVEC_NWORDS];
typedef bitvec_t gf2elem_t;           /* this type will represent field elements */
typedef bitvec_t scalar_t;
 

/******************************************************************************/

/* Here the curve parameters are defined. */

#if defined (ECC_CURVE) && (ECC_CURVE != 0)
 #if (ECC_CURVE == NIST_K163)
  #define coeff_a  1
  #define cofactor 2
/* NIST K-163 */
const gf2elem_t polynomial = { 0x000000c9, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000008 }; 
 #endif

 #if (ECC_CURVE == NIST_K233)
  #define coeff_a  0
  #define cofactor 4
/* NIST K-233 */
const gf2elem_t polynomial = { 0x00000001, 0x00000000, 0x00000400, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000200 };
 #endif

 #if (ECC_CURVE == NIST_K409)
  #define coeff_a  0
  #define cofactor 4
/* NIST K-409 */
const gf2elem_t polynomial = { 0x00000001, 0x00000000, 0x00800000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x02000000 };  
 #endif

  #if (ECC_CURVE == NIST_K113)
    const gf2elem_t polynomial = { 0x00000001, 0x00000002, 0x00000000, 0x00020000};
  #endif

  #if (ECC_CURVE == NIST_K193)
    const gf2elem_t polynomial = { 0x00008001, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002};
  #endif

#endif

/*************************************************************************************************/

/* Private / functions: */


/* some basic bit-manipulation routines that act on bit-vectors follow */
int bitvec_get_bit(const bitvec_t x, const uint32_t idx)
{
  return ((x[idx / 32U] >> (idx & 31U) & 1U));
}

void bitvec_clr_bit(bitvec_t x, const uint32_t idx)
{
  x[idx / 32U] &= ~(1U << (idx & 31U));
}

void bitvec_copy(bitvec_t x, const bitvec_t y)
{
  int i;
  for (i = 0; i < BITVEC_NWORDS; ++i)
  {
    x[i] = y[i];
  }
}

void bitvec_swap(bitvec_t x, bitvec_t y)
{
  bitvec_t tmp;
  bitvec_copy(tmp, x);
  bitvec_copy(x, y);
  bitvec_copy(y, tmp);
}

#if defined(CONST_TIME) && (CONST_TIME == 0)
/* fast version of equality test */
int bitvec_equal(const bitvec_t x, const bitvec_t y)
{
  int i;
  for (i = 0; i < BITVEC_NWORDS; ++i)
  {
    if (x[i] != y[i])
    {
      return 0;
    }
  }
  return 1;
}
#else
/* constant time version of equality test */
int bitvec_equal(const bitvec_t x, const bitvec_t y)
{
  int ret = 1;
  int i;
  for (i = 0; i < BITVEC_NWORDS; ++i)
  {
    ret &= (x[i] == y[i]);
  }
  return ret;
}
#endif

void bitvec_set_zero(bitvec_t x)
{
  int i;
  for (i = 0; i < BITVEC_NWORDS; ++i)
  {
    x[i] = 0;
  }
}

#if defined(CONST_TIME) && (CONST_TIME == 0)
/* fast implementation */
int bitvec_is_zero(const bitvec_t x)
{
  uint32_t i = 0;
  while (i < BITVEC_NWORDS)
  {
    if (x[i] != 0)
    {
      break;
    }
    i += 1;
  }
  return (i == BITVEC_NWORDS);
}
#else
/* constant-time implementation */
int bitvec_is_zero(const bitvec_t x)
{
  int ret = 1;
  int i = 0;
  for (i = 0; i < BITVEC_NWORDS; ++i)
  {
    ret &= (x[i] == 0);
  }
  return ret;
}
#endif

/* return the number of the highest one-bit + 1 */
int bitvec_degree(const bitvec_t x)
{
  int i = BITVEC_NWORDS * 32;

  /* Start at the back of the vector (MSB) */
  x += BITVEC_NWORDS;

  /* Skip empty / zero words */
  while (    (i > 0)
          && (*(--x)) == 0)
  {
    i -= 32;
  }
  /* Run through rest if count is not multiple of bitsize of DTYPE */
  if (i != 0)
  {
    uint32_t u32mask = ((uint32_t)1 << 31);
    while (((*x) & u32mask) == 0)
    {
      u32mask >>= 1;
      i -= 1;
    }
  }
  return i;
}

/* left-shift by 'count' digits */
void bitvec_lshift(bitvec_t x, const bitvec_t y, int nbits)
{
  int nwords = (nbits / 32);

  /* Shift whole words first if nwords > 0 */
  int i,j;
  for (i = 0; i < nwords; ++i)
  {
    /* Zero-initialize from least-significant word until offset reached */
    x[i] = 0;
  }
  j = 0;
  /* Copy to x output */
  while (i < BITVEC_NWORDS)
  {
    x[i] = y[j];
    i += 1;
    j += 1;
  }

  /* Shift the rest if count was not multiple of bitsize of DTYPE */
  nbits &= 31;
  if (nbits != 0)
  {
    /* Left shift rest */
    int i;
    for (i = (BITVEC_NWORDS - 1); i > 0; --i)
    {
      x[i]  = (x[i] << nbits) | (x[i - 1] >> (32 - nbits));
    }
    x[0] <<= nbits;
  }
}


/*************************************************************************************************/
/*
  Code that does arithmetic on bit-vectors in the Galois Field GF(2^CURVE_DEGREE).
*/
/*************************************************************************************************/


void gf2field_set_one(gf2elem_t x)
{
  /* Set first word to one */
  x[0] = 1;
  /* .. and the rest to zero */
  int i;
  for (i = 1; i < BITVEC_NWORDS; ++i)
  {
    x[i] = 0;
  }
}

#if defined(CONST_TIME) && (CONST_TIME == 0)
/* fastest check if x == 1 */
int gf2field_is_one(const gf2elem_t x) 
{
  /* Check if first word == 1 */
  if (x[0] != 1)
  {
    return 0;
  }
  /* ...and if rest of words == 0 */
  int i;
  for (i = 1; i < BITVEC_NWORDS; ++i)
  {
    if (x[i] != 0)
    {
      break;
    }
  }
  return (i == BITVEC_NWORDS);
}
#else
/* constant-time check */
int gf2field_is_one(const gf2elem_t x)
{
  int ret = 0;
  /* Check if first word == 1 */
  if (x[0] == 1)
  {
    ret = 1;
  }
  /* ...and if rest of words == 0 */
  int i;
  for (i = 1; i < BITVEC_NWORDS; ++i)
  {
    ret &= (x[i] == 0);
  }
  return ret; //(i == BITVEC_NWORDS);
}
#endif


/* galois field(2^m) addition is modulo 2, so XOR is used instead - 'z := a + b' */
void gf2field_add(gf2elem_t z, const gf2elem_t x, const gf2elem_t y)
{
  int i;
  for (i = 0; i < BITVEC_NWORDS; ++i)
  {
    z[i] = (x[i] ^ y[i]);
  }
}

/* increment element */
void gf2field_inc(gf2elem_t x)
{
  x[0] ^= 1;
}


/* field multiplication 'z := (x * y)' */
void gf2field_mul(gf2elem_t z, const gf2elem_t x, const gf2elem_t y)
{
  int i;
  gf2elem_t tmp;
#if defined(CONST_TIME) && (CONST_TIME == 1)
  gf2elem_t blind;
  bitvec_set_zero(blind);
#endif
  //assert(z != y);

  bitvec_copy(tmp, x);

  /* LSB set? Then start with x */
  if (bitvec_get_bit(y, 0) != 0)
  {
    bitvec_copy(z, x);
  }
  else /* .. or else start with zero */
  {
    bitvec_set_zero(z);
  }

  /* Then add 2^i * x for the rest */
  for (i = 1; i < CURVE_DEGREE; ++i)
  {
    /* lshift 1 - doubling the value of tmp */
    bitvec_lshift(tmp, tmp, 1);

    /* Modulo reduction polynomial if degree(tmp) > CURVE_DEGREE */
    if (bitvec_get_bit(tmp, CURVE_DEGREE))
    {
      gf2field_add(tmp, tmp, polynomial);
    }
#if defined(CONST_TIME) && (CONST_TIME == 1)
    else /* blinding operation */
    {
      gf2field_add(tmp, tmp, blind);
    }
#endif

    /* Add 2^i * tmp if this factor in y is non-zero */
    if (bitvec_get_bit(y, i))
    {
      gf2field_add(z, z, tmp);
    }
#if defined(CONST_TIME) && (CONST_TIME == 1)
    else /* blinding operation */
    {
      gf2field_add(z, z, blind);
    }
#endif
  }
}

#if (ECC_CURVE == NIST_K409)
  const gf2elem_t a = { 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff };
  const gf2elem_t b = { 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff };
#endif

#if (ECC_CURVE == NIST_K233)
  const gf2elem_t a = { 0x00000001, 0x00000000, 0x00000400, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000200 };
  const gf2elem_t b = { 0x00000001, 0x00000000, 0x00000400, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000200 };
#endif

#if (ECC_CURVE == NIST_K113)
  const gf2elem_t a = { 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff};
  const gf2elem_t b = { 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff};
#endif

#if (ECC_CURVE == NIST_K193)
  const gf2elem_t a = { 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff};
  const gf2elem_t b = { 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff};
#endif

gf2elem_t result;

extern uint64_t get_mcycle();

uint32_t empty_r;
uint32_t result_d[13];

int main (){
  long time1, time2;

#if (ECC_CURVE == NIST_K409)
  printf("Starting a GF(2^409) multiplication in C code... \n\r");
#endif

#if (ECC_CURVE == NIST_K233)
  printf("Starting a GF(2^233) multiplication in C code... \n\r");
#endif

#if (ECC_CURVE == NIST_K113)
  printf("Starting a GF(2^113) multiplication in C code... \n\r");
#endif

#if (ECC_CURVE == NIST_K193)
  printf("Starting a GF(2^193) multiplication in C code... \n\r");
#endif

  time1 = get_mcycle();
  //gf2field_mul(result, a, b);

#if (ECC_CURVE == NIST_K409)
  asm volatile
          (   
              "ffloadas   %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)empty_r)
              : [x] "r" ((uint32_t)0xffffffff), [y] "r" ((uint32_t)0xffffffff)
          );  

  asm volatile
          (   
              "ffloada    %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)empty_r)
              : [x] "r" ((uint32_t)0xffffffff), [y] "r" ((uint32_t)0xffffffff)
          );  
  asm volatile
          (   
              "ffloada    %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)empty_r)
              : [x] "r" ((uint32_t)0xffffffff), [y] "r" ((uint32_t)0xffffffff)
          );  
  asm volatile
          (   
              "ffloada    %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)empty_r)
              : [x] "r" ((uint32_t)0xffffffff), [y] "r" ((uint32_t)0xffffffff)
          );  
  asm volatile
          (   
              "ffloada    %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)empty_r)
              : [x] "r" ((uint32_t)0xffffffff), [y] "r" ((uint32_t)0xffffffff)
          );  
  asm volatile
          (   
              "ffloada    %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)empty_r)
              : [x] "r" ((uint32_t)0xffffffff), [y] "r" ((uint32_t)0xffffffff)
          );  
  asm volatile
          (   
              "ffloadae   %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)empty_r)
              : [x] "r" ((uint32_t)0xffffffff), [y] "r" ((uint32_t)0xffffffff)
          );   



  asm volatile
          (   
              "ffloadbs   %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)empty_r)
              : [x] "r" ((uint32_t)0xffffffff), [y] "r" ((uint32_t)0xffffffff)
          );  

  asm volatile
          (   
              "ffloadb    %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)empty_r)
              : [x] "r" ((uint32_t)0xffffffff), [y] "r" ((uint32_t)0xffffffff)
          );  
  asm volatile
          (   
              "ffloadb    %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)empty_r)
              : [x] "r" ((uint32_t)0xffffffff), [y] "r" ((uint32_t)0xffffffff)
          );  
  asm volatile
          (   
              "ffloadb    %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)empty_r)
              : [x] "r" ((uint32_t)0xffffffff), [y] "r" ((uint32_t)0xffffffff)
          );  
  asm volatile
          (   
              "ffloadb    %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)empty_r)
              : [x] "r" ((uint32_t)0xffffffff), [y] "r" ((uint32_t)0xffffffff)
          );  
  asm volatile
          (   
              "ffloadb    %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)empty_r)
              : [x] "r" ((uint32_t)0xffffffff), [y] "r" ((uint32_t)0xffffffff)
          );  
  asm volatile
          (   
              "ffloadbe   %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)empty_r)
              : [x] "r" ((uint32_t)0xffffffff), [y] "r" ((uint32_t)0xffffffff)
          );


  asm volatile
          (   
              "ffmul1   %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)result_d[0])
              : [x] "r" ((uint32_t)0), [y] "r" ((uint32_t)0)
          );          
  asm volatile
          (   
              "ffmul1   %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)result_d[1])
              : [x] "r" ((uint32_t)0), [y] "r" ((uint32_t)0)
          );             
  asm volatile
          (   
              "ffmul1   %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)result_d[2])
              : [x] "r" ((uint32_t)0), [y] "r" ((uint32_t)0)
          );       
  asm volatile
          (   
              "ffmul1   %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)result_d[3])
              : [x] "r" ((uint32_t)0), [y] "r" ((uint32_t)0)
          );      
  asm volatile
          (   
              "ffmul1   %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)result_d[4])
              : [x] "r" ((uint32_t)0), [y] "r" ((uint32_t)0)
          );   
  asm volatile
          (   
              "ffmul1   %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)result_d[5])
              : [x] "r" ((uint32_t)0), [y] "r" ((uint32_t)0)
          );         
  asm volatile
          (   
              "ffmul1   %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)result_d[6])
              : [x] "r" ((uint32_t)0), [y] "r" ((uint32_t)0)
          );   
  asm volatile
          (   
              "ffmul1   %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)result_d[7])
              : [x] "r" ((uint32_t)0), [y] "r" ((uint32_t)0)
          );  
  asm volatile
          (   
              "ffmul1   %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)result_d[8])
              : [x] "r" ((uint32_t)0), [y] "r" ((uint32_t)0)
          );   
  asm volatile
          (   
              "ffmul1   %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)result_d[9])
              : [x] "r" ((uint32_t)0), [y] "r" ((uint32_t)0)
          );         
  asm volatile
          (   
              "ffmul1   %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)result_d[10])
              : [x] "r" ((uint32_t)0), [y] "r" ((uint32_t)0)
          );   
  asm volatile
          (   
              "ffmul1   %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)result_d[11])
              : [x] "r" ((uint32_t)0), [y] "r" ((uint32_t)0)
          );                      
  asm volatile
          (   
              "ffmul1   %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)result_d[12])
              : [x] "r" ((uint32_t)0), [y] "r" ((uint32_t)0)
          );      
#endif  
#if (ECC_CURVE == NIST_K233)
  asm volatile
          (   
              "ffloadas   %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)empty_r)
              : [x] "r" ((uint32_t)0xffffffff), [y] "r" ((uint32_t)0xffffffff)
          );  

  asm volatile
          (   
              "ffloada    %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)empty_r)
              : [x] "r" ((uint32_t)0xffffffff), [y] "r" ((uint32_t)0xffffffff)
          );  
  asm volatile
          (   
              "ffloada    %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)empty_r)
              : [x] "r" ((uint32_t)0xffffffff), [y] "r" ((uint32_t)0xffffffff)
          );  
  asm volatile
          (   
              "ffloadae   %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)empty_r)
              : [x] "r" ((uint32_t)0xffffffff), [y] "r" ((uint32_t)0xffffffff)
          );   



  asm volatile
          (   
              "ffloadbs   %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)empty_r)
              : [x] "r" ((uint32_t)0xffffffff), [y] "r" ((uint32_t)0xffffffff)
          );  

  asm volatile
          (   
              "ffloadb    %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)empty_r)
              : [x] "r" ((uint32_t)0xffffffff), [y] "r" ((uint32_t)0xffffffff)
          );  
  asm volatile
          (   
              "ffloadb    %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)empty_r)
              : [x] "r" ((uint32_t)0xffffffff), [y] "r" ((uint32_t)0xffffffff)
          );  
  asm volatile
          (   
              "ffloadbe   %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)empty_r)
              : [x] "r" ((uint32_t)0xffffffff), [y] "r" ((uint32_t)0xffffffff)
          );


  asm volatile
          (   
              "ffmul2   %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)result_d[0])
              : [x] "r" ((uint32_t)0), [y] "r" ((uint32_t)0)
          );          
  asm volatile
          (   
              "ffmul2   %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)result_d[1])
              : [x] "r" ((uint32_t)0), [y] "r" ((uint32_t)0)
          );             
  asm volatile
          (   
              "ffmul2   %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)result_d[2])
              : [x] "r" ((uint32_t)0), [y] "r" ((uint32_t)0)
          );       
  asm volatile
          (   
              "ffmul2   %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)result_d[3])
              : [x] "r" ((uint32_t)0), [y] "r" ((uint32_t)0)
          );      
  asm volatile
          (   
              "ffmul2   %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)result_d[4])
              : [x] "r" ((uint32_t)0), [y] "r" ((uint32_t)0)
          );   
  asm volatile
          (   
              "ffmul2   %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)result_d[5])
              : [x] "r" ((uint32_t)0), [y] "r" ((uint32_t)0)
          );         
  asm volatile
          (   
              "ffmul2   %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)result_d[6])
              : [x] "r" ((uint32_t)0), [y] "r" ((uint32_t)0)
          );   
  asm volatile
          (   
              "ffmul2   %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)result_d[7])
              : [x] "r" ((uint32_t)0), [y] "r" ((uint32_t)0)
          ); 
#endif

#if (ECC_CURVE == NIST_K193)
  asm volatile
          (   
              "ffloadas   %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)empty_r)
              : [x] "r" ((uint32_t)0xffffffff), [y] "r" ((uint32_t)0xffffffff)
          );  

  asm volatile
          (   
              "ffloada    %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)empty_r)
              : [x] "r" ((uint32_t)0xffffffff), [y] "r" ((uint32_t)0xffffffff)
          );  
  asm volatile
          (   
              "ffloada    %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)empty_r)
              : [x] "r" ((uint32_t)0xffffffff), [y] "r" ((uint32_t)0xffffffff)
          );  
  asm volatile
          (   
              "ffloadae   %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)empty_r)
              : [x] "r" ((uint32_t)0xffffffff), [y] "r" ((uint32_t)0xffffffff)
          );   



  asm volatile
          (   
              "ffloadbs   %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)empty_r)
              : [x] "r" ((uint32_t)0xffffffff), [y] "r" ((uint32_t)0xffffffff)
          );  

  asm volatile
          (   
              "ffloadb    %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)empty_r)
              : [x] "r" ((uint32_t)0xffffffff), [y] "r" ((uint32_t)0xffffffff)
          );  
  asm volatile
          (   
              "ffloadb    %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)empty_r)
              : [x] "r" ((uint32_t)0xffffffff), [y] "r" ((uint32_t)0xffffffff)
          );  
  asm volatile
          (   
              "ffloadbe   %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)empty_r)
              : [x] "r" ((uint32_t)0xffffffff), [y] "r" ((uint32_t)0xffffffff)
          );


  asm volatile
          (   
              "ffmul3   %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)result_d[0])
              : [x] "r" ((uint32_t)0), [y] "r" ((uint32_t)0)
          );          
  asm volatile
          (   
              "ffmul3   %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)result_d[1])
              : [x] "r" ((uint32_t)0), [y] "r" ((uint32_t)0)
          );             
  asm volatile
          (   
              "ffmul3   %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)result_d[2])
              : [x] "r" ((uint32_t)0), [y] "r" ((uint32_t)0)
          );       
  asm volatile
          (   
              "ffmul3   %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)result_d[3])
              : [x] "r" ((uint32_t)0), [y] "r" ((uint32_t)0)
          );      
  asm volatile
          (   
              "ffmul3   %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)result_d[4])
              : [x] "r" ((uint32_t)0), [y] "r" ((uint32_t)0)
          );   
  asm volatile
          (   
              "ffmul3   %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)result_d[5])
              : [x] "r" ((uint32_t)0), [y] "r" ((uint32_t)0)
          );         
  asm volatile
          (   
              "ffmul3   %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)result_d[6])
              : [x] "r" ((uint32_t)0), [y] "r" ((uint32_t)0)
          );   
#endif

#if (ECC_CURVE == NIST_K113)
  asm volatile
          (   
              "ffloadas   %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)empty_r)
              : [x] "r" ((uint32_t)0xffffffff), [y] "r" ((uint32_t)0xffffffff)
          );    
  asm volatile
          (   
              "ffloadae   %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)empty_r)
              : [x] "r" ((uint32_t)0xffffffff), [y] "r" ((uint32_t)0xffffffff)
          );   



  asm volatile
          (   
              "ffloadbs   %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)empty_r)
              : [x] "r" ((uint32_t)0xffffffff), [y] "r" ((uint32_t)0xffffffff)
          );  
  asm volatile
          (   
              "ffloadbe   %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)empty_r)
              : [x] "r" ((uint32_t)0xffffffff), [y] "r" ((uint32_t)0xffffffff)
          );


  asm volatile
          (   
              "ffmul4   %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)result_d[0])
              : [x] "r" ((uint32_t)0), [y] "r" ((uint32_t)0)
          );          
  asm volatile
          (   
              "ffmul4   %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)result_d[1])
              : [x] "r" ((uint32_t)0), [y] "r" ((uint32_t)0)
          );             
  asm volatile
          (   
              "ffmul4   %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)result_d[2])
              : [x] "r" ((uint32_t)0), [y] "r" ((uint32_t)0)
          );       
  asm volatile
          (   
              "ffmul4   %[z], %[x], %[y]\n\t"
              : [z] "=r" ((uint32_t)result_d[3])
              : [x] "r" ((uint32_t)0), [y] "r" ((uint32_t)0)
          );      
#endif

  time2 = get_mcycle();

  for (int i=0;i<13;i++)
    printf("%x\n\r", result_d[i]);

  printf("SUCCESS! \t %d cycles\n",time2-time1);                                                          
}