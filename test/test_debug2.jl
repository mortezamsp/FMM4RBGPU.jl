using Revise
using FMM4RBGPU_timing
using CUDA
using Dates  

# Small test
const N = 1000
positions = rand(3, N)
momenta = zeros(3, N)
beam = Particles(; pos=positions, mom=momenta, charge=-1.0, mass=1.0)

const n = 4 
const N0 = 125  
const eta = 0.5

println("=== DEBUGGING METHOD DISPATCH ===")
println("beam type: ", typeof(beam))
println("FMM type: ", typeof(FMM(eta=eta, N0=N0, n=n)))

# Check which method will be called
meths = methods(update_particles_field!, (typeof(beam), typeof(FMM(eta=eta, N0=N0, n=n))))
println("Matching methods: ", length(meths))
for meth in meths
    println("  - ", meth)
end

# Try calling with explicit types
println("Calling function...")
result = update_particles_field!(beam, FMM(eta=eta, N0=N0, n=n); lambda=1.0)
println("Function completed")