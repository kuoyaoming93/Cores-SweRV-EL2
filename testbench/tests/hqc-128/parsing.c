/**
 * @file parsing.c
 * @brief Functions to parse secret key, public key and ciphertext of the HQC scheme
 */

#include "shake_prng.h"
#include "parameters.h"
#include "parsing.h"
#include "vector.h"
#include <stdint.h>
#include <string.h>


/**
 * @brief Parse a secret key into a string
 *
 * The secret key is composed of the seed used to generate vectors <b>x</b> and <b>y</b>.
 * As technicality, the public key is appended to the secret key in order to respect NIST API.
 *
 * @param[out] sk String containing the secret key
 * @param[in] sk_seed Seed used to generate the secret key
 * @param[in] pk String containing the public key
 */
void hqc_secret_key_to_string(uint8_t *sk, const uint8_t *sk_seed, const uint8_t *pk) {
    memcpy(sk, sk_seed, SEED_BYTES);
    memcpy(sk + SEED_BYTES, pk, PUBLIC_KEY_BYTES);
}



/**
 * @brief Parse a secret key from a string
 *
 * The secret key is composed of the seed used to generate vectors <b>x</b> and <b>y</b>.
 * As technicality, the public key is appended to the secret key in order to respect NIST API.
 *
 * @param[out] x uint64_t representation of vector x
 * @param[out] y uint32_t representation of vector y
 * @param[out] pk String containing the public key
 * @param[in] sk String containing the secret key
 */
void hqc_secret_key_from_string(uint64_t *x, uint32_t *y, uint8_t *pk, const uint8_t *sk) {
    seedexpander_state sk_seedexpander;
    uint8_t sk_seed[SEED_BYTES] = {0};

    memcpy(sk_seed, sk, SEED_BYTES);
    seedexpander_init(&sk_seedexpander, sk_seed, SEED_BYTES);

    vect_set_random_fixed_weight(&sk_seedexpander, x, PARAM_OMEGA);
    vect_set_random_fixed_weight_by_coordinates(&sk_seedexpander, y, PARAM_OMEGA);
    memcpy(pk, sk + SEED_BYTES, PUBLIC_KEY_BYTES);
}



/**
 * @brief Parse a public key into a string
 *
 * The public key is composed of the syndrome <b>s</b> as well as the seed used to generate the vector <b>h</b>
 *
 * @param[out] pk String containing the public key
 * @param[in] pk_seed Seed used to generate the public key
 * @param[in] s uint8_t representation of vector s
 */
void hqc_public_key_to_string(uint8_t *pk, const uint8_t *pk_seed, const uint64_t *s) {
    memcpy(pk, pk_seed, SEED_BYTES);
    memcpy(pk + SEED_BYTES, s, VEC_N_SIZE_BYTES);
}



/**
 * @brief Parse a public key from a string
 *
 * The public key is composed of the syndrome <b>s</b> as well as the seed used to generate the vector <b>h</b>
 *
 * @param[out] h uint8_t representation of vector h
 * @param[out] s uint8_t representation of vector s
 * @param[in] pk String containing the public key
 */
void hqc_public_key_from_string(uint64_t *h, uint64_t *s, const uint8_t *pk) {
    seedexpander_state pk_seedexpander;
    uint8_t pk_seed[SEED_BYTES] = {0};

    memcpy(pk_seed, pk, SEED_BYTES);
    seedexpander_init(&pk_seedexpander, pk_seed, SEED_BYTES);
    vect_set_random(&pk_seedexpander, h);

    memcpy(s, pk + SEED_BYTES, VEC_N_SIZE_BYTES);
}



/**
 * @brief Parse a ciphertext into a string
 *
 * The ciphertext is composed of vectors <b>u</b>, <b>v</b> and hash <b>d</b>.
 *
 * @param[out] ct String containing the ciphertext
 * @param[in] u uint8_t representation of vector u
 * @param[in] v uint8_t representation of vector v
 * @param[in] d String containing the hash d
 */
void hqc_ciphertext_to_string(uint8_t *ct, const uint64_t *u, const uint64_t *v, const uint8_t *d) {
    memcpy(ct, u, VEC_N_SIZE_BYTES);
    memcpy(ct + VEC_N_SIZE_BYTES, v, VEC_N1N2_SIZE_BYTES);
    memcpy(ct + VEC_N_SIZE_BYTES + VEC_N1N2_SIZE_BYTES, d, SHAKE256_512_BYTES);
}



/**
 * @brief Parse a ciphertext from a string
 *
 * The ciphertext is composed of vectors <b>u</b>, <b>v</b> and hash <b>d</b>.
 *
 * @param[out] u uint8_t representation of vector u
 * @param[out] v uint8_t representation of vector v
 * @param[out] d String containing the hash d
 * @param[in] ct String containing the ciphertext
 */
void hqc_ciphertext_from_string(uint64_t *u, uint64_t *v, uint8_t *d, const uint8_t *ct) {
    memcpy(u, ct, VEC_N_SIZE_BYTES);
    memcpy(v, ct + VEC_N_SIZE_BYTES, VEC_N1N2_SIZE_BYTES);
    memcpy(d, ct + VEC_N_SIZE_BYTES + VEC_N1N2_SIZE_BYTES, SHAKE256_512_BYTES);
}
