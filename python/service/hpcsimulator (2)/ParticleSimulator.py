# -*- coding: utf-8 -*-

#from matplotlib import pyplot as plt
#from matplotlib import animation
from lib.Particle import Particle
from random import uniform

class ParticleSimulator:

    __slots__ = ('n_particles', 'lst_particles', 'timestep')

    def __init__(self, n_particles, timestep=0.01):
        self.n_particles = n_particles
        self.lst_particles = []
        self.timestep = timestep



    def generate_random_particles(self, logger):
        for n in range(self.n_particles):
            logger.info('particle ' + str(n) + ' created')
            p = Particle(logger, round(uniform(-1.0, 1.0), 4), round(uniform(-1.0, 1.0), 4)
                                , round(uniform(-1.0, 1.0), 4), round(uniform(-1.0, 1.0), 4))
            logger.info('particle parameters: ' + str(p.get_x())
                                                + ', ' + str(p.get_x())
                                                + ', ' + str(p.get_y())
                                                + ', ' + str(p.get_ang_vel())
                                                + ', ' + str(p.get_rad_vel()))
            self.lst_particles.append(p)


    def evolve_particles_system(self, logger):
        for p in self.lst_particles:
            logger.info('evolution particle ' + str(self.lst_particles.index(p)))
            p.evolve(timestep=self.timestep)
            logger.info('particle parameters: ' + str(p.get_x())
                        + ', ' + str(p.get_x())
                        + ', ' + str(p.get_y())
                        + ', ' + str(p.get_ang_vel())
                        + ', ' + str(p.get_rad_vel()))




