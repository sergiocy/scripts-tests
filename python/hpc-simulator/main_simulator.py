# -*- coding: utf-8 -*-

from service.utils import create_logger

from lib.Particle import Particle


LOG_FILE_PATH = '../../../log/hpc_simulator.log'


if __name__ == '__main__':
    logger = create_logger(LOG_FILE_PATH)

    logger.info('creating particles')
    p1 = Particle(1,1,3)
    p2 = Particle(2, 2, 2)
    print(p1.get_x())
    print(p2.get_x())
