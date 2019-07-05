# -*- coding: utf-8 -*-

class Particle:
    def __init__(self, x, y, ang_vel):
        self.x = x
        self.y = y
        self.ang_vel = ang_vel
        print('particle created \n')
        
        
        
    def get_x(self):
        print('returning x: ' + str(self.x))
        return(self.x)
    
    def get_y(self):
        print('returning y: ' + str(self.y))
        return(self.y)
        
    def get_ang_vel(self):
        print('returning angular velocity: ' + str(self.ang_vel))
        return(self.ang_vel)     
        
    def set_x(self, x):
        print('setting x: ' + str(x))
        self.x = x
    
    def set_y(self, y):
        print('setting y: ' + str(y))
        self.y = y
        
    def set_ang_vel(self, ang_vel):
        print('setting angular velocity: ' + str(ang_vel))
        self.ang_vel = ang_vel 
        