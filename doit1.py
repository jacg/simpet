import os
import simpet
import logging_utils

logging_utils.log_to_stdout_and_file("doit1.log")

DATA = os.getenv('SIMPET_DATA_DIR')

#simpet.SimPET(f'{DATA}/test_image/testParams.yml').run()
simpet.SimPET('doit1-test-params.yml').run()
