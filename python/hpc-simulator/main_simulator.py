# -*- coding: utf-8 -*-

from service.utils import create_logger
from service.utils import remove_file_if_exists

from lib.Particle import Particle
from lib.ParticleSimulator import ParticleSimulator


LOG_FILE_PATH = '../../../log/simulator.log'


if __name__ == '__main__':
    remove_file_if_exists(LOG_FILE_PATH)
    logger = create_logger(LOG_FILE_PATH)

    ####
    #### define system of N particles
    N = 1
    logger.info('system created with {0} particles'.format(str(N)))
    simulator = ParticleSimulator(N, timestep=0.01)
    simulator.generate_random_particles(logger)

    ####
    #### evolve n_steps times
    n_steps = 3
    for step in range(n_steps):
        logger.info('step evolution {0}'.format(str(step)))
        simulator.evolve_particles_system(logger)



