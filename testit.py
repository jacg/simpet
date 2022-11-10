from os import getenv

from simpet import SimPET

DATA = getenv('SIMPET_DATA_DIR')

SimPET(f'{DATA}/test_image/testParams.yml').run()
