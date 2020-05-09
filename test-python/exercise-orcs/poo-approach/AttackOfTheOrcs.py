# -*- coding: utf-8 -*-
"""
Created on Sat Sep 15 11:27:23 2018

@author: sergio
"""

from Knight import Knight
from Hut import Hut
from OrcRider import OrcRider
import random
# import sys


class AttackOfTheOrcs:
    def __init__(self, n_huts, name_player):
        self.n_huts = n_huts
        self.huts = []
        self.player = Knight(name_player)
        #print(n_huts)
        
    def get_occupants(self):
        for i in range(self.n_huts):
            print(str(i))
            print('hut ' + str(i) + ' occupied by '); self.huts[i].print_number(); self.huts[i].print_occupant()
    

    def get_occupant_in_any_hut(self, n):
        try:
            h = self.huts[n]
        except IndexError as e:
            print('errooooooor')
            h = self.huts[len(self.huts)-1]
        finally:
            if h.occupant is not None:
                h.print_number()
                h.print_occupant()
                h.occupant.print_name()
            else:
                print('empty hut')


    #def show_game_mission(self):
        
    #def _process_user_choice(self):
        
    def _occupy_huts(self):
        for i in range(self.n_huts):
            #print(i)
            choice_lst = ['enemy', 'friend', None]
            computer_choice = random.choice(choice_lst)
            if computer_choice == 'enemy':
                name = 'enemy-' + str(i+1)
                self.huts.append(Hut(i+1, OrcRider(name)))
            elif computer_choice == 'friend':
                name = 'knight-' + str(i+1)
                self.huts.append(Hut(i+1, Knight(name)))
            else:
                self.huts.append(Hut(i+1, computer_choice))
                
            
        
    def play(self):
        #print('huts: ' + str(self.n_huts))
        self._occupy_huts()
        print('huts: ' + str(len(self.huts)))
        
        #self.get_occupants()
        
        print(self.player.print_name())
        
        self.get_occupant_in_any_hut(3)
        
        print('the end')
        
        '''
        self.player = Knight()
        self._occupy_huts()
        acquired_hut_counter = 0
        
        self.show_game_mission()
        self.player.show_health(bold = True)
        
        while acquired_hut_counter < 5:
            idx = self._process_user_choice()
            self.player.acquire_hut(self.huts[idx-1])
            
            if self.player.health_meter <= 0:
                print_bold("YOU LOSE!!")
                break
            
            if self.huts[idx-1].is_acquired:
                acquired_hut_counter += 1
                
        if acquired_hut_counter == 5:
            print_bold("YOU WIN!!")
        '''
        
if __name__ == '__main__':
    game = AttackOfTheOrcs(5, 'Sergio')
    game.play()