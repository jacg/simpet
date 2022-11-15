"""
This script installs the necessary files to run simpet, including all the required dependencies.
Don't run this script if you think all the needed dependencies are already fulfilled.
"""
import os
from os.path import join, exists

import logging
import sys


logging.basicConfig(filename='setup.log', encoding='utf-8', level=logging.DEBUG)

root    = logging.getLogger()
handler = logging.StreamHandler(sys.stdout)

root   .setLevel(logging.DEBUG)
handler.setLevel(logging.DEBUG)

formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
handler.setFormatter(formatter)

root.addHandler(handler)


def verify_test_simulation(simpet_dir):
    print('\nVerifying test simulation...')
    import nibabel as nib
    import numpy as np

    results_dir = join(simpet_dir, 'Results', 'Test', 'SimSET_Sim_Discovery_ST', 'division_0')

    checks = ['trues.hdr', 'scatter.hdr', 'randoms.hdr']

    for i in checks:
        file_ = join(results_dir, i)
        if exists(file_):
            img_d = nib.load(file_).get_fdata()
            counts = np.sum(img_d)
            print("Counts in %s: %s" % (i,counts))

        else:
            raise Exception('Failed to build %s' % i)

    results_dir = join(simpet_dir, 'Results', 'Test', 'SimSET_Sim_Discovery_ST', 'OSEM3D')

    checks = ['rec_OSEM3D_32.v', 'rec_OSEM3D_32.hv']
    for i in checks:
        file_ = join(results_dir, i)
        if exists(file_):
            print('%s: OK' % i)
        else:
            raise Exception('Failed to reconstruct %s' % i)


print("\nEverything looks good... we will launch a quick simulation now just to be sure...")
print("This can take a bit, maybe 15 min... you may abort it if you are very sure what you are doing.\n")

import simpet


DATA = os.getenv('SIMPET_DATA_DIR')

simpet.SimPET(f'{DATA}/test_image/testParams.yml').run()

verify_test_simulation(simpet_dir)
