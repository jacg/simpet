import sys
import logging

def log_to_stdout_and_file(filename, level=logging.DEBUG):

    format = '%(asctime)s - %(name)s - %(levelname)s - %(message)s'

    logging.basicConfig(filename=filename, encoding='utf-8', level=level, format=format)

    root    = logging.getLogger()
    handler = logging.StreamHandler(sys.stdout)

    root   .setLevel(logging.DEBUG)
    handler.setLevel(logging.DEBUG)

    formatter = logging.Formatter(format)
    handler.setFormatter(formatter)

    root.addHandler(handler)
