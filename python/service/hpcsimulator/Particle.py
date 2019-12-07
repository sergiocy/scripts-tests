# -*- coding: utf-8 -*-

class Particle:

    __slots__ = ('x', 'y', 'ang_vel', 'rad_vel')

    def __init__(self, logger, x, y, ang_vel, rad_vel):
        self.x = x
        self.y = y
        self.ang_vel = ang_vel
        self.rad_vel = rad_vel
        logger.info('particle created')

    def get_x(self):
        return(self.x)
    
    def get_y(self):
        return(self.y)
        
    def get_ang_vel(self):
        return(self.ang_vel)

    def get_rad_vel(self):
        return(self.rad_vel)
        
    def set_x(self, x):
        self.x = x
    
    def set_y(self, y):
        self.y = y
        
    def set_ang_vel(self, ang_vel):
        self.ang_vel = ang_vel


    def evolve(self, timestep=0.01):
        v_x = -self.y / (self.x ** 2 + self.y ** 2) ** 0.5
        v_y = self.x / (self.x ** 2 + self.y ** 2) ** 0.5

        d_x = timestep * v_x * self.ang_vel
        d_y = timestep * v_y * self.ang_vel

        self.x = round(self.x + d_x, 4)
        self.y = round(self.y + d_y, 4)
        