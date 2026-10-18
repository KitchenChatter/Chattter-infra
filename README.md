# Chattter Platform - Infrastructure Configuration

This repository houses the **Infrastructure as Code (IaC)** blueprints for the Chattter platform. It uses **Terraform** to declare, version, and automatically provision containerized system dependencies.

## 🏗️ Architecture Component
- **Provider:** Docker Engine (kreuzwerker/docker)
- **Target Resources:** Local automated Nginx container server environment
- **State Management:** Local tracking (excluded from source version control via `.gitignore`)

## 🛠️ Execution & Lifecycle Workflow

### Prerequisites
- [Docker Desktop](https://docker.com) must be active.
- [tfenv](https://github.com) installed via Homebrew to lock down the Terraform runtime edition (`v1.16.6`).

### 1. Provisioning Initialize
Downloads essential backend provider modules and configures working directories:
```bash
terraform init
```

### 2. Execution Previews (Dry Run)
Generates non-destructive infrastructure changesets to let you audit what resources will be added, modified, or destroyed before execution:
```bash
terraform plan
```

### 3. Apply Environment Upgrades
Locks in changesets and directly stands up your live container configurations:
```bash
terraform apply
```

### 4. Tearing Down Infrastructure
Wipes out all managed running container configurations and resources created by this blueprint, leaving your machine completely clean:
```bash
terraform destroy
```

## ⚠️ SRE Note: Apple macOS Socket Routing
Due to how Docker Desktop isolates processes on macOS, the default Unix communication socket is routed through the specific user profile directory rather than standard Linux system paths. Ensure the `host` argument variable inside the `provider "docker"` block correctly reflects your profile:
`unix:///Users/mrOwens/.docker/run/docker.sock`
