/**
 * PCG32 - minimal C implementation
 *
 * State is passed in/out via a pcg32_state_t pointer supplied by the
 * caller (no global/static state). Each call to pcg32_random_r()
 * advances the state and returns the next 32-bit random value.
 *
 * This reproduces the same sequence as the pure-PHP fallback
 * (PhpPcg32.php) and the GMP version (Pcg32.php) for the same
 * seed/sequence, since both are just 64-bit-limb emulations of this
 * native 64-bit arithmetic.
 */
#ifndef PCG32_H
#define PCG32_H

#include <stdint.h>
#include <stddef.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef struct {
    uint64_t state; /* RNG state. All values are possible. */
    uint64_t inc;   /* Controls which RNG sequence (stream) is selected. Must *always* be odd. */
} pcg32_state_t;

/**
 * Initialize (seed) an RNG state. Equivalent to PhpPcg32::__construct()
 * + setSeed(): inc is derived from `sequence`, then two step()s are
 * used to mix in the seed.
 */
void pcg32_srandom_r(pcg32_state_t *rng, uint64_t seed, uint64_t sequence);

/**
 * Generate a uniformly distributed 32-bit random number and advance
 * the state pointed to by `rng`.
 * Equivalent to PhpPcg32::randUint32().
 */
uint32_t pcg32_random_r(pcg32_state_t *rng);

/**
 * Reinterpret an unsigned 32-bit value as a signed 32-bit value
 * (two's complement bit pattern preserved).
 * Equivalent to PhpPcg32::uint32ToInt32().
 */
int32_t pcg32_uint32_to_int32(uint32_t u);

/**
 * Next random number as a signed 32-bit integer.
 * Equivalent to PhpPcg32::nextInt32().
 */
int32_t pcg32_next_int32(pcg32_state_t *rng);

/**
 * Next random number as a double in [0, 1).
 * Equivalent to PhpPcg32::nextFloat().
 */
double pcg32_next_float(pcg32_state_t *rng);

/**
 * Next random integer in the inclusive range [min, max], using
 * rejection sampling to avoid modulo bias.
 * Equivalent to PhpPcg32::nextInt().
 */
int64_t pcg32_next_int(pcg32_state_t *rng, int64_t min, int64_t max);

/**
 * Fill `out[0..size)` with values uniformly distributed in
 * [low, high). Equivalent to PhpPcg32::fillUniform().
 */
void pcg32_fill_uniform(pcg32_state_t *rng, double *out, size_t size, double low, double high);

#ifdef __cplusplus
}
#endif

#endif /* PCG32_H */
