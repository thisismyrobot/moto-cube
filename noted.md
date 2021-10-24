# algorithm for separation angle between boxes

r = cam inner radius
c = cam outer radius
d = cam rotation from zero (radians!)

a = 2 * tan^(-1)((c * sin(90 - cos^(-1)(r/c) + d) - r) / (r + sqrt(c^2-(c * sin(90 - cos^(-1)(r/c) + d))^2)))

