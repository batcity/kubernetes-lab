# Alright, my plan is to create a deployment with 
# three nginx pods that share a persistent volume
# the three ngninx services are stateless within each container
# but they share the same volume/persistent storage -
# so they always serve the same data even if one pod goes down


def create_persistent_volume():
    # TODO