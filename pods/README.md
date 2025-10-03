# Pods

A **Pod** is the smallest deployable unit in Kubernetes.  
It represents **one or more containers** that share:

- **Networking** – containers in a Pod share the same IP address and port space.  
- **Storage** – containers in a Pod can share volumes for persistent data.  

Pods are **ephemeral**: if a Pod dies, Kubernetes can create a new one, but it is not the same Pod.  
For production workloads, Pods are usually managed by **higher-level controllers** like Deployments, which handle scaling, updates, and self-healing.  

## Example use cases

- **Single-container Pod**: a simple nginx web server.  
- **Multi-container Pod**: an application container with a logging or sidecar container.  

## Quick commands

```bash
# Run a simple nginx Pod
kubectl run nginx --image=nginx

# List all Pods
kubectl get pods
