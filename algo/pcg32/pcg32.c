/**
 * PCG32 - minimal C implementation (see pcg32.h)
 *
 * Native 64-bit arithmetic is used directly (no limb emulation is
 * needed in C, unlike PhpPcg32.php), but the algorithm and the order
 * of operations match PhpPcg32.php exactly so the two produce
 * identical output streams for the same seed/sequence.
 */
#include "pcg32.h"

/* 6364136223846793005 == 0x5851F42D4C957F2D, the PCG default multiplier. */
static const uint64_t PCG32_MULT = 0x5851F42D4C957F2DULL;

/* Advance the state by one step: state = state * MULT + inc (mod 2^64). */
static void pcg32_step(pcg32_state_t *rng)
{
    rng->state = rng->state * PCG32_MULT + rng->inc;
}

void pcg32_srandom_r(pcg32_state_t *rng, uint64_t seed, uint64_t sequence)
{
    /* inc = (sequence << 1) | 1, always odd */
    rng->inc = (sequence << 1u) | 1u;

    rng->state = 0u;
    pcg32_step(rng);
    rng->state += seed;
    pcg32_step(rng);
}

uint32_t pcg32_random_r(pcg32_state_t *rng)
{
    uint64_t oldstate = rng->state;
    pcg32_step(rng);

    uint32_t xorshifted = (uint32_t)(((oldstate >> 18u) ^ oldstate) >> 27u);
    uint32_t rot = (uint32_t)(oldstate >> 59u);

    return (xorshifted >> rot) | (xorshifted << ((-rot) & 31u));
}

int32_t pcg32_uint32_to_int32(uint32_t u)
{
    return (int32_t)u; /* two's complement reinterpretation */
}

int32_t pcg32_next_int32(pcg32_state_t *rng)
{
    return pcg32_uint32_to_int32(pcg32_random_r(rng));
}

double pcg32_next_float(pcg32_state_t *rng)
{
    return (double)pcg32_random_r(rng) / 4294967296.0;
}

int64_t pcg32_next_int(pcg32_state_t *rng, int64_t min, int64_t max)
{
    uint64_t range = (uint64_t)(max - min + 1);
    uint64_t threshold, r;

    if (max < min) {
        /* Mirrors PhpPcg32::nextInt()'s InvalidArgumentException case.
           Adjust error handling to fit your project's conventions. */
        return min;
    }

    threshold = (0x100000000ULL - range) % range;
    do {
        r = (uint64_t)pcg32_random_r(rng);
    } while (r < threshold);

    return min + (int64_t)(r % range);
}

void pcg32_fill_uniform(pcg32_state_t *rng, double *out, size_t size, double low, double high)
{
    double scale = high - low;
    size_t i;
    for (i = 0; i < size; i++) {
        out[i] = low + pcg32_next_float(rng) * scale;
    }
}
