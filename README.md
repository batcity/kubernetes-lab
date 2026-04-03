# Kubernetes Lab:

This repository contains code and advanced concepts for learning Kubernetes.
Each concept has its own folder with a Python script and README explaining the idea.

## Table of Contents

### Workloads
- [Pods](./pods/README.md)
- [Deployments](./deployments/README.md)

### Networking
- [Services](./services/README.md)
- [Ingress](./ingress/README.md)

### Configuration & Security
- [ConfigMaps](./configmaps/README.md)
- [Secrets](./secrets/README.md)

### Storage
- [Persistent Volumes](./persistent-volume/README.md)

### Multi-tenancy
- [Namespaces](./namespaces/README.md)

## Setup

1. Run:
    ```bash
    . ./setup.sh
    ```
2. Verify cluster is running:
    ```bash
    kubectl get nodes
    ```
3. Run Python scripts, e.g.:
    ```bash
    python pods/pods.py
    python deployments/deployments.py
    python services/services.py
    ```

💡 **Note:** This lab uses [**kind**](https://kind.sigs.k8s.io/) (Kubernetes IN Docker) to create a lightweight, local Kubernetes cluster.
It allows you to experiment with Kubernetes safely on your own machine without needing a cloud account or VM.  

## Running YAML Manifests

In addition to the Python examples, this lab also includes Kubernetes YAML manifests.

### Apply a manifest

Use `kubectl apply` to create resources:

```bash
kubectl apply -f <path-to-yaml>
```

### Examples

```bash
kubectl apply -f deployments/deployments.yaml
kubectl apply -f persistent-volume/persisent_volume_claim.yaml
kubectl apply -f persistent-volume/persistent_volume.yaml
```

### Verify resources

```bash
kubectl get pods
kubectl get deployments
kubectl get pvc
```

### Delete resources

```bash
kubectl delete -f <path-to-yaml>
```

💡 Note: Make sure your local cluster is running (`kubectl get nodes`) before applying manifests.

## Cleanup

- To delete the local cluster:
    ```bash
    ./kind delete cluster --name k8s-lab
    ```
- To deactivate Python environment:
    ```bash
    deactivate
    ```
