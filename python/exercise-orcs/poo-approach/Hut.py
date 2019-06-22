# -*- coding: utf-8 -*-
"""
Created on Sat Sep 15 13:25:12 2018

@author: sergio
"""

class Hut:
    def __init__(self, number_hut, occupant):
        self.number_hut = number_hut
        self.occupant = occupant
        
    def print_number(self):
        print(str(self.number_hut))
        
    def print_occupant(self):
        print(self.occupant)
        
