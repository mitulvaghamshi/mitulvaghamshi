# Decorators allows any function to re execute based on set of pre-conditions.
# Useful in network requests to retry on failure.
# This example uses decorator to retry upto five times on exception.
# The decorator will stop retrying on success.

import logging
from time import sleep
from functools import wraps

counter = 0
logging.basicConfig()
log = logging.getLogger("retry")

def retry(func):
    @wraps(func)
    def wrapper(*args, **kwargs):
        MAX_ATTEMPTS = 5
        for attempt in range(1, MAX_ATTEMPTS + 1):
            try:
                return func(*args, **kwargs)
            except:
                log.exception("Attempt %s/%s failed : %s", attempt, MAX_ATTEMPTS, (args, kwargs))
                sleep(2 + attempt)
        log.critical("All %s attempts failed : %s", MAX_ATTEMPTS, (args, kwargs))
    return wrapper

@retry
def perform_task(value):
    print("Processing...")
    global counter
    counter += 1
    if counter <= 3:
        raise ValueError(value)
    else:
        print("Done! at attempt: #", counter)

perform_task("Bad Ipnut")
