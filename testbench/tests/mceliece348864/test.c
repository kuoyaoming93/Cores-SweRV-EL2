#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include "crypto_kem.h"
#include "randombytes.h"
#include "gf.h"

#define KAT_SUCCESS          0
#define KAT_CRYPTO_FAILURE  -4

static void phex(uint8_t* str, uint8_t len);

//unsigned char seed[48];

extern unsigned char sk[6492];
extern unsigned char pk[261120];
extern uint64_t get_mcycle();

int main(void)
{
    int ret_val;
    int i;
    unsigned char ct[crypto_kem_CIPHERTEXTBYTES];
    unsigned char ss[crypto_kem_BYTES];
    unsigned char ss1[crypto_kem_BYTES];
    /*unsigned char pk[crypto_kem_PUBLICKEYBYTES];
    unsigned char sk[crypto_kem_SECRETKEYBYTES];*/

    // Create seed
    /*randombytes(seed, 256);
    printf("seed = ");
    phex(seed,48);

    if ( (ret_val = crypto_kem_keypair(pk, sk)) != 0) {
            printf("crypto_kem_keypair returned <%d>\n", ret_val);
            return KAT_CRYPTO_FAILURE;
        }*/
    //gf result = gf_mul(500,800);
    //gf result2 = gf_mul(1024,512);
    //printf("Result: %d\n",result);
    //printf("Result2: %d\n",result2);

    printf("pk = %d\n", pk[0]);
    printf("sk = %d\n", sk[0]);
    printf("pk = %d\n", pk[261119]);
    printf("sk = %d\n", sk[6491]);

    long time1,time2;
    time1 = get_mcycle();
    if ( (ret_val = crypto_kem_enc(ct, ss, pk)) != 0) {
        printf("crypto_kem_enc returned <%d>\n", ret_val);
        return KAT_CRYPTO_FAILURE;
    }
    time2 = get_mcycle();
	printf("ENC: %d cycles\n",time2-time1);

    //printf("ct = %s\n", ct);
    //printf("ss = %s\n", ss);

    time1 = get_mcycle();
    if ( (ret_val = crypto_kem_dec(ss1, ct, sk)) != 0) {
        printf("crypto_kem_dec returned <%d>\n", ret_val);
        return KAT_CRYPTO_FAILURE;
    }
    time2 = get_mcycle();
	printf("DEC: %d cycles\n",time2-time1);
    
    if ( memcmp(ss, ss1, crypto_kem_BYTES) ) {
        printf("crypto_kem_dec returned bad 'ss' value\n");
        return KAT_CRYPTO_FAILURE;
    }

    return 0;
}

static void phex(uint8_t* str, uint8_t len)
{
    unsigned char i;
    for (i = 0; i < len; ++i)
        printf("%02x", str[i]);
    printf("\n");
}






