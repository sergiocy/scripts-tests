# -*- coding: utf-8 -*-
"""
Created on Sat Sep  8 11:16:24 2018

@author: sergio
"""

import random
import textwrap

#print('FIRST MISSION: select a hut')
# occupation = ['enemy', 'friend', 'unoccupied']


def presentation():
    # Print the game mission
    width = 72
    dotted_line = '-' * width
    print(dotted_line)
    print("\033[1m" + "Attack of The Orcs v0.0.1:" + "\033[0m")
    
    '''
    msg = ("..................")
    print(textwrap.fill(msg, width=width))
    print("\033[1m" + "Mission:" + "\033[0m")
    print("\tChoose a hut where Sir Foo can rest...")
    print("\033[1m" + "TIP:" + "\033[0m")
    print("Be careful as there are enemies lurking around!")
    print(dotted_line)
    '''
    #print(occupants)
 
    
def fill_huts():
    n_huts = int(input('how many huts are there?: '))
    occupants = ['enemy', 'friend', 'unoccupied']
    print(occupants)
    huts = []
    while len(huts) < n_huts:
        huts.append(random.choice(occupants))
        
    return(huts)
    
def attack():
    sir_health = 10
    enemy_health = 10
    round_attack = 1
    result = 1
    
    
    while (sir_health > 0 and enemy_health > 0):
        sir_health = sir_health - random.randint(0, 3) 
        enemy_health = enemy_health - random.randint(0, 3)
        print('round ')
        print('round ', round_attack, '--- sir: ', sir_health, ' - enemy: ', enemy_health)
        round_attack = round_attack + 1
    
    if sir_health <= 0:
        result = 0
    elif enemy_health <= 0:
        result = 1
    else:
        result = 0
        
    return(result)
    
    

def run_app():
    presentation()
    occupants = fill_huts()
    print(occupants)
    
    keep_playing = 'y'
    while keep_playing == 'y':
        selection = random.choice(occupants)
        print(selection)
        
        if(selection == 'enemy'):
            print('there is an enemy!!! attacking!!!')
            result = attack()
            if result == 0:
                print('...uf!... I lose')
            else:
                print('I win!!!')
        elif(selection == 'friend'):
            print('are you my friend?? ... hi... could I stay in your home?')
        else:
            print('that hut is empty... i will can rest...')
            
        keep_playing = input('play again? (y/n): ')
    
    
if __name__ == '__main__':
    print('executing as standalone app')
    run_app()
    