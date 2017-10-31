rng = MemorizingRNG(MersenneTwister(12))

a = rand(rng)
rand(rng)
rand(rng)
rand(rng)

rng.idx=0
@test rand(rng) == a

randn(rng)

rng.idx=0
b = randn(rng, 2)
randn(rng, 2)
randn(rng, 2)
randn(rng, 2)
rng.idx=0
@test b == randn(rng, 2)

src = MemorizingSource(1, 2, MersenneTwister(12))

rng = ARDESPOT.get_rng(src, 1, 1)
r1 = rand(rng)
rng2 = ARDESPOT.get_rng(src, 1, 2)
r2 = rand(rng2)
rng = ARDESPOT.get_rng(src, 1, 1)
@test r1 == rand(rng)
r3 = rand(rng)
@test src.move_count == 1
rng2 = ARDESPOT.get_rng(src, 1, 2)
@test r2 == rand(rng2)
rng = ARDESPOT.get_rng(src, 1, 1)
@test r1 == rand(rng)
@test r3 == rand(rng)

@test src.move_count == 1

println("A warning should be thrown below.")
ARDESPOT.check_consistency(src)
