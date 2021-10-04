#include <stdio.h>
#include "api.h"
#include "parameters.h"

extern uint64_t get_mcycle();

int main() {

	printf("\n");
	printf("**************************\n");
	printf("**** HQC-RMRS-%d-%d ****\n", PARAM_SECURITY, PARAM_DFR_EXP);
	printf("**************************\n");

	printf("\n");
	printf("N: %d   ", PARAM_N);
	printf("N1: %d   ", PARAM_N1);
	printf("N2: %d   ", PARAM_N2);
	printf("OMEGA: %d   ", PARAM_OMEGA);
	printf("OMEGA_R: %d   ", PARAM_OMEGA_R);
	printf("Failure rate: 2^-%d   ", PARAM_DFR_EXP);
	printf("Sec: %d bits", PARAM_SECURITY);
	printf("\n");

	long time1,time2;

    time1 = get_mcycle();
	unsigned char pk[PUBLIC_KEY_BYTES];
	unsigned char sk[SECRET_KEY_BYTES];
	unsigned char ct[CIPHERTEXT_BYTES];
	unsigned char key1[SHARED_SECRET_BYTES];
	unsigned char key2[SHARED_SECRET_BYTES];
	time2 = get_mcycle();
	printf("pepe %d cycles\n",time2-time1);

    time1 = get_mcycle();
	crypto_kem_keypair(pk, sk);
	time2 = get_mcycle();
	printf("Keygen %d cycles\n",time2-time1);

	/*time1 = get_mcycle();
	crypto_kem_enc(ct, key1, pk);
	time2 = get_mcycle();
	printf("%d cycles\n",time2-time1);

	time1 = get_mcycle();
	crypto_kem_dec(key2, ct, sk);
	time2 = get_mcycle();
	printf("%d cycles\n",time2-time1);

	printf("\n\nsecret1: ");
	for(int i = 0 ; i < SHARED_SECRET_BYTES ; ++i) printf("%x", key1[i]);

	printf("\nsecret2: ");
	for(int i = 0 ; i < SHARED_SECRET_BYTES ; ++i) printf("%x", key2[i]);
	printf("\n\n");*/

	return 0;
}
