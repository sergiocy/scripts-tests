# -*- coding: utf-8 -*-
"""
Created on Sat Sep 15 13:24:58 2018

@author: sergio
"""

from GameUnit import GameUnit

class OrcRider(GameUnit):
    def __init__(self, name):
        super().__init__(name)
        #self.name = name
        
        
    def print_group_orc(self):
        print("pertenzco a un grupo de orcos")