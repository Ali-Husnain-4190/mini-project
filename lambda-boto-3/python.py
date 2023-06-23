class Robot:
    def __init__(self, name):
        self.name = name
        self.x = 0
        self.y = 0

    def move_up(self):
        self.y += 1

    def move_down(self):
        self.y -= 1

    def move_left(self):
        self.x -= 1

    def move_right(self):
        self.x += 1

    def get_position(self):
        return self.x, self.y


# Create a robot instance
robot = Robot("MyRobot")

# Move the robot
robot.move_up()
robot.move_right()
robot.move_down()

# Get the robot's position
x, y = robot.get_position()
print(f"{robot.name} is at position ({x}, {y})")
