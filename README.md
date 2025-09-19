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

## Cleanup

- To delete the local cluster:
    ```bash
    ./kind delete cluster --name k8s-lab
    ```
- To deactivate Python environment:
    ```bash
    deactivate
    ```
