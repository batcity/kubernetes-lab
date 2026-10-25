#!/usr/bin/env bash

VENV_DIR=".venv"

# 1️⃣ Create / activate virtual environment
if [ -d "$VENV_DIR" ]; then
    echo "✅ Virtual environment already exists in $VENV_DIR"
    echo "👉 Activating it..."
else
    echo "🚀 Creating virtual environment in $VENV_DIR..."
    python3 -m venv "$VENV_DIR"
fi

source "$VENV_DIR/bin/activate"

# 2️⃣ Upgrade pip
echo "⬆️  Upgrading pip..."
pip install --upgrade pip

# 3️⃣ Install Python dependencies
echo "📥 Installing dependencies..."
pip install kubernetes

# 4️⃣ Check Docker
if ! command -v docker >/dev/null 2>&1; then
    echo "⚠️ Docker not found. kind requires Docker to run a local Kubernetes cluster."
    echo "Please install Docker: https://docs.docker.com/get-docker/"
    exit 1
else
    echo "🐳 Docker found!"
fi

# 5️⃣ Check kind and download if missing
KIND_BINARY="./kind"
if [ ! -f "$KIND_BINARY" ]; then
    echo "⚠️ kind not found. Installing locally to the repo folder..."

    OS=$(uname | tr '[:upper:]' '[:lower:]')
    ARCH=$(uname -m)

    if [ "$OS" = "darwin" ]; then
        if [ "$ARCH" = "x86_64" ]; then
            KIND_ARCH="amd64"
        elif [ "$ARCH" = "arm64" ]; then
            KIND_ARCH="arm64"
        else
            echo "❌ Unsupported architecture: $ARCH"
            exit 1
        fi
    elif [ "$OS" = "linux" ]; then
        if [ "$ARCH" = "x86_64" ]; then
            KIND_ARCH="amd64"
        elif [ "$ARCH" = "aarch64" ]; then
            KIND_ARCH="arm64"
        else
            echo "❌ Unsupported architecture: $ARCH"
            exit 1
        fi
    else
        echo "❌ Unsupported OS: $OS"
        exit 1
    fi

    KIND_URL="https://kind.sigs.k8s.io/dl/v0.25.0/kind-$OS-$KIND_ARCH"

    echo "🔹 Detected OS: $OS"
    echo "🔹 Detected Architecture: $ARCH"
    echo "🔹 Using kind binary architecture: $KIND_ARCH"
    echo "🔹 Download URL: $KIND_URL"

    curl -Lo "$KIND_BINARY" "$KIND_URL"
    chmod +x "$KIND_BINARY"

    echo "🔹 Downloaded kind binary info:"
    file "$KIND_BINARY"
fi

# 6️⃣ Create or restart Kubernetes cluster
CONTAINER_NAME="k8s-lab-control-plane"

if docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    echo "ℹ️ Cluster 'k8s-lab' is already running."
elif docker ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    echo "🔄 Cluster container exists but is stopped. Starting it..."
    docker start "$CONTAINER_NAME" >/dev/null
    
    # Re-sync host port & kubeconfig
    "$KIND_BINARY" export kubeconfig --name k8s-lab >/dev/null 2>&1
    
    echo "⏳ Waiting for control plane to initialize..."
    retries=15
    until kubectl get nodes >/dev/null 2>&1 || [ $retries -eq 0 ]; do
        sleep 2
        ((retries--))
    done

    if [ $retries -eq 0 ]; then
        echo "⚠️ Cluster took too long to respond. Resetting cluster..."
        "$KIND_BINARY" delete cluster --name k8s-lab
        "$KIND_BINARY" create cluster --name k8s-lab
    fi
else
    echo "🚀 Creating Kubernetes cluster 'k8s-lab'..."
    "$KIND_BINARY" create cluster --name k8s-lab
fi

# 7️⃣ Instructions
echo ""
echo "🎉 Setup complete!"
echo "👉 To deactivate the environment: deactivate"
echo "👉 Current Python: $(which python)"
echo "👉 Current Pip:    $(which pip)"
echo ""
echo "💡 Local Kubernetes cluster 'k8s-lab' is ready!"
echo "💡 Example: Run a script against your local cluster:"
echo "   python pods/pods.py"
echo ""
echo "💡 You can check cluster nodes:"
echo "   kubectl get nodes"
echo ""
echo "💡 To delete the cluster later:"
echo "   ./kind delete cluster --name k8s-lab"
echo ""
echo "💡 kind was installed locally in the repo."
