# Plot the box motion versus the cam motion, over different values.
#
# Install:
#           pipenv install
# Run:
#           pipenv run python plot.py
#
import math

import matplotlib.pyplot


def box_angle_degrees(cam_angle_degrees, cam_inner_radius, cam_outer_radius):
    # Shorthand variables as per other implementations
    d = math.radians(cam_angle_degrees)
    r = float(cam_inner_radius)
    c = float(cam_outer_radius)

    if d < math.acos(r/c):
        return math.degrees(2 * math.atan((c * math.sin(math.radians(90) - math.acos(r/c) + d) - r) / (r + math.sqrt(pow(c, 2) - pow(c * math.sin(math.radians(90) - math.acos(r/c) + d), 2)))))
    else:
        return math.degrees(2 * math.atan((c * math.sin(math.radians(90) - math.acos(r/c) + d) - r) / (r - math.sqrt(pow(c, 2) - pow(c * math.sin(math.radians(90) - math.acos(r/c) + d), 2)))))


def plot(cam_inner_radius, cam_outer_radius):
    x_percents = range(101)
    matplotlib.pyplot.xlabel('Sweep (%)')

    y_cam_angles = [p * 90 / 100
                   for p
                   in x_percents]
    matplotlib.pyplot.plot(x_percents, y_cam_angles)

    y_box_angles = [abs(box_angle_degrees(a, 10, 22) / 2.0)
                    for a
                    in y_cam_angles]
    matplotlib.pyplot.plot(x_percents, y_box_angles)
    matplotlib.pyplot.ylabel(f'Cam: {cam_inner_radius}/{cam_outer_radius}')

    matplotlib.pyplot.title('My first graph!')
    matplotlib.pyplot.show()


if __name__ == '__main__':
    plot(11, 22)
