# Persistent Volume

Persistent volume is a piece of storage in the cluster that's either provisioned by an administrator or dynamically provisioned. It is a resource in the cluster just like a node, they have an independent lifecycle different from the pods that consume them.

You can use the following command to view the persistent volumes in a cluster

```kubectl get pv```

# Persistent Volume Claim

A **Persistent Volume Claim (PVC)** is a storage "voucher." 

It is the API object that lets a developer say: *"I need 20GB of storage with Read/Write access,"* without needing to know if that storage is a physical disk, a cloud bucket, or a network drive.

### The 3-Step Logic
* **The Request:** You define the **size** and **access mode** in a YAML file.
* **The Binding:** Kubernetes matches your request to an available **Persistent Volume (PV)** or creates a new one automatically via a **StorageClass**.
* **The Mount:** The Pod "claims" the volume and uses it like a local folder, ensuring data survives even if the Pod restarts or moves.

### The "Restaurant" Analogy
* **Persistent Volume (PV):** A specific table in the restaurant.
* **Persistent Volume Claim (PVC):** Your reservation for a table that seats four.
* **StorageClass:** The host who finds (or sets up) a table that fits your reservation.

You can use the following command to view the persistent volume claims in a cluster:


```kubectl get pvc```