# Release Notes: Version 0.2.0

## Changes
- The Spaces interface is now the official interface.
- A Dict type has been added to Spaces.
- The Dict type is returned as the observation when using Masked Actions.
- Masking via `Info` has been deprecated.
- Code modifications are required because the return types for `reset` and `step` have changed due to updates regarding Masked Actions and the Dict type.
- The random number generator has been standardized to a custom implementation of Pcg32.
- Random number behavior has changed because the system is now independent of PHP's `srand`/`rand`.
- `srand` can no longer be used to reset the random number generator; use `reset(seed:$seed)` if you need to reset it individually.
- The random number generator now inherits its initial state from `rindow-math-matrix` upon environment instance creation.
