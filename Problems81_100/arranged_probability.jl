# Find the first arrangement of blue and red discs in a box such that the probability of taking two blue discs at random is exactly 1/2, and the total number of discs exceeds 10^12.

# x + y = z

# P(x2) = x/z * (x-1)/z-1

# x/z * (x-1)/z-1 = 0.5

# (x*x - x)/(z*z - z) = 0.5
# x*x - x = 0.5*(z*z - z)
# z*z - z = 2*x*x - 2*x
# z*z - z + 2*x - 2*x*x = 0

# (2*x - 2*x*x) = s

# z*z - z + s = 0

# z = -b +- sqrt(b*b - 4ac)/2a
# z = 1 +- sqrt(1 - 4s)/2
# z = 1 + sqrt(1 - 4s)/2

# 1 - 4s > 0
# 1 + 8*x*x - 8*x > 0

# Step1: Iterate until the first solution is found
x = BigInt(2)
z = BigInt(0)
while true
    D = 1 + 8*x*x - 8*x
    root_D = isqrt(D)
    if root_D * root_D == D
        global z = (1 + root_D) ÷ 2
        println("Found initial solution with total number of disks: $(string(x)), number of blue disks: $(string(z))")
        break
    end
    global x += 1
end

# Step2: Apply Pell equation to iteratively find the next solutions
# 2x(x-1)=z(z-1)
# 2x*x - 2x = z*z - z
# 8*x*x - 8*x + 2 - 2 = 4*z*z - 4*z + 1 - 1
# s = 2x - 1, s*s = 4*x*x - 4*x + 1
# t = 2z - 1, t*t = 4*z*z - 4*z + 1
# 2*(4*x*x -4*x + 1) - 2 = 4*z*z - 4*z + 1 - 1
# 2*s*s - 2 = t*t - 1
# t*t - 2*s*s = -1
# Solve for t,s 
# t_next = 3*t + 4*s
# z_next = (t_next + 1)/2
# z_next = (3*t + 4*s + 1)/2
# s_next = 2*t + 3*s
# x_next = (s_next + 1)/2
# x_next = (2*t + 3*s + 1)/2


ceiling = BigInt(10)^12
while true
    next_z = (3*(2*z - 1) + 4*(2*x - 1) + 1) ÷ 2
    next_x = (2*(2*z - 1) + 3*(2*x - 1) + 1) ÷ 2
    println("Next solution with total number of disks: $(string(next_z)), number of blue disks: $(string(next_x))")
    if next_z > ceiling
        break
    end
    global x = next_x
    global z = next_z
end