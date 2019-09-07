# -*- coding: utf-8 -*-
"""
Created on Sat Sep 15 12:38:26 2018

@author: sergio
"""

from GameUnit import GameUnit

class Knight(GameUnit):
    def __init__(self, name):
        super().__init__(name)
        #self.name = name
        
        
    def print_group_knight(self):
        print('pertenezco a un grupo de caballeros')