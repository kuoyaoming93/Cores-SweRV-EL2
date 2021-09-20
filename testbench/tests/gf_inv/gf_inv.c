#include <stdio.h>
#include <stdint.h>

#define NBITS 16
#define CUSTOM_CODES

extern uint64_t get_mcycle();

uint8_t gf_mult(uint8_t a, uint8_t b)
{
#ifdef CUSTOM_CODES
    uint32_t imm_result,result;
    asm volatile
                (   
                    "clmul   %[z], %[x], %[y]\n\t"
                    : [z] "=r" ((uint32_t)imm_result)
                    : [x] "r" ((uint32_t)a), [y] "r" ((uint32_t)b)
                );  
    asm volatile
                (   
                    "ffred   %[z], %[x], %[y]\n\t"
                    : [z] "=r" ((uint32_t)result)
                    : [x] "r" ((uint32_t)0), [y] "r" ((uint32_t)imm_result)
                );  
    return (uint8_t) result;
#else
    uint8_t p = 0;
    while (a && b) {
            if (b & 1) 
                p ^= a; 
#if (NBITS == 8)
            if (a & 0x80) 
                a = (a << 1) ^ 0x11d; 
#elif (NBITS == 4)
            if (a & 0x8) 
                a = (a << 1) ^ 0x13; 
#endif
            else
                a <<= 1; /* equivalent to a*2 */
            b >>= 1; /* equivalent to b // 2 */
	}
    return p;
#endif
}

uint16_t gf_mult16(uint16_t a, uint16_t b)
{
#ifdef CUSTOM_CODES
    uint32_t imm_result,result;
    asm volatile
                (   
                    "clmul   %[z], %[x], %[y]\n\t"
                    : [z] "=r" ((uint32_t)imm_result)
                    : [x] "r" ((uint32_t)a), [y] "r" ((uint32_t)b)
                );  
    asm volatile
                (   
                    "ffred   %[z], %[x], %[y]\n\t"
                    : [z] "=r" ((uint32_t)result)
                    : [x] "r" ((uint32_t)0), [y] "r" ((uint32_t)imm_result)
                );  
    return (uint16_t) result;
#else
    uint16_t p = 0;
    while (a && b) {
            if (b & 1) 
                p ^= a; 
            if (a & 0x8000) 
                a = (a << 1) ^ 0x1100B; 
            else
                a <<= 1; /* equivalent to a*2 */
            b >>= 1; /* equivalent to b // 2 */
	}
    return p;
#endif
}

uint8_t gf_square(uint8_t a)
{
    return gf_mult(a,a);
}

uint16_t gf_square16(uint16_t a)
{
    return gf_mult16(a,a);
}

uint8_t gf_inv(uint8_t a)
{
    uint8_t i=0;
    uint8_t aux = gf_square(a);
    uint8_t aux2=aux;

    for (i = 0; i < (NBITS-2); i++)
    {
        aux = gf_square(aux);
        aux2 = gf_mult(aux,aux2);
    }
    return aux2;
}

uint16_t gf_inv16(uint16_t a)
{
    uint16_t i=0;
    uint16_t aux = gf_square16(a);
    uint16_t aux2=aux;

    for (i = 0; i < (NBITS-2); i++)
    {
        aux = gf_square16(aux);
        aux2 = gf_mult16(aux,aux2);
    }
    return aux2;
}

int main (void)
{
    
    int a,b;
    int p = 0, inv = 0; 

    // GF(2^16)
    a=128;
    b=4096;

    // GF(2^8)
    //a=160;
    //b=22;

    // GF(2^4)
    //a=12;
    //b=7;



#ifdef CUSTOM_CODES
    uint32_t empty_rd;
#if (NBITS == 8)
    asm volatile
            (   
                "ffwidth   %[z], %[x], %[y]\n\t"
                : [z] "=r" ((uint32_t)empty_rd)
                : [x] "r" ((uint32_t)8), [y] "r" ((uint32_t)0x11D)
            );  
#elif (NBITS == 4)
    asm volatile
            (   
                "ffwidth   %[z], %[x], %[y]\n\t"
                : [z] "=r" ((uint32_t)empty_rd)
                : [x] "r" ((uint32_t)4), [y] "r" ((uint32_t)0x13)
            );  
#elif (NBITS == 16)
    asm volatile
            (   
                "ffwidth   %[z], %[x], %[y]\n\t"
                : [z] "=r" ((uint32_t)empty_rd)
                : [x] "r" ((uint32_t)16), [y] "r" ((uint32_t)0x1100B)
            );  
#endif
#endif

    //p = gf_mult(a,b);
    p = gf_mult16(a,b);

    long time1,time2;
    time1 = get_mcycle();
    //inv = gf_inv(a);
    inv = gf_inv16(a);
    time2 = get_mcycle();

    printf("%d cycles\n",time2-time1);
	
    printf("El producto es: %d\n", p);
    printf("La inversa de A es: %d\n", inv);
	return 0;
}