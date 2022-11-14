import logging
import subprocess

def rsystem(command, capture=True):
    """
    Executes command, raise an error if it fails and send status to logfile
    :param command: (string) command to be executed
    :return:
    """

    logging.info(f'EXECUTING: {command}')
    if capture: res = subprocess.run(command, shell=True, capture_output=True)
    else      : res = subprocess.run(command, shell=True, stderr=subprocess.STDOUT)

    if res.returncode:
        logging.error(f'FAILED   : {command}')
        if capture:
            logging.error('FAILURE OUTPUT BELOW THIS LINE')
            logging.error(res.stdout)
            logging.error('FAILURE OUTPUT ABOVE THIS LINE')
    else:
        logging.info(f'COMPLETED: {command}')
