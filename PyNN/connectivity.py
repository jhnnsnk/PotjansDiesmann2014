###################################################
###     	Connection routine		###        
###################################################

import numpy as np
from network_params import *
from pyNN.random import RandomDistribution


def FixedTotalNumberConnect(sim, pop1, pop2, K, w_mean, w_sd, d_mean, d_sd, rng=None):
    n_syn = int(round(K * len(pop2)))
    conn = sim.FixedTotalNumberConnector(n_syn, rng=rng)
    d_distr = RandomDistribution('normal_clipped', [d_mean, d_sd, 0.1, np.inf], rng=rng)
    if pop1.annotations['type'] == 'E' :
        conn_type = 'excitatory'
        w_distr = RandomDistribution('normal_clipped', [w_mean, w_sd, 0., np.inf], rng=rng)
    else :
        conn_type = 'inhibitory'
        w_distr = RandomDistribution('normal_clipped', [w_mean, w_sd, -np.inf, 0.], rng=rng)

    syn = sim.StaticSynapse(weight=w_distr, delay=d_distr)
    proj = sim.Projection(pop1, pop2, conn, syn, receptor_type=conn_type)
