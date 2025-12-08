# AWS Cloud Project

This is a full-stack cloud infrastructure deployment project deployed on AWS Cloud

## ✅ Project Features

- 🚀 Infrastructure-as-Code with Terraform for automated AWS provisioning  
- 🐳 Dockerized Node.js (Express) application deployed to AWS EKS  
- ☁️ AWS resources: VPC, EKS, CloudWatch, OpenSearch, Prometheus, Grafana  
- 🔁 GitOps continuous delivery with FluxCD and ArgoCD  
- 🌐 Service Mesh with Istio for traffic management, observability, and security  
- 📊 Centralized observability using CloudWatch, Prometheus, and Grafana dashboards  
- ⚙️ CI/CD pipeline integration and automation for consistent deployments  


## 🧱 Project Structure

```
aws-cloud-infra-project/
├── app/                  # Node.js application
│   ├── index.js
│   └── Dockerfile
├── terraform/            # Infrastructure definition
│   ├── main.tf
│   ├── variables.tf
│   ├── helm/
│   │   ├── prometheus-values.yaml
│   │   ├── grafana-values.yaml
│   │   ├── argocd-values.yaml
│   │   ├── fluxcd-values.yaml
│   │   └── istio-values.yaml
│   ├── README.md  
│   └── modules/
│       ├── vpc/
│       ├── iam/
│       ├── alb/
│       ├── ecs/
│       └── observability/
├── azure-pipelines.yml   # CI/CD pipeline definition
├── .gitignore
├── sample-app/           # Node.js Express app
├── flux/                 # Flux manifests (for GitOps sync)
├── argo/                 # ArgoCD manifests or Apps
├── istio-1.27.3/         # Istio CLI & sample profiles
└── k8s/                  # Kubernetes manifests

```

## 🛠 Deployment Process

1. **Infrastructure Provisioning (Terraform)**  
   - Creates AWS resources: VPC, EKS Cluster, IAM Roles, and Security Groups  
   - Deploys CloudWatch, OpenSearch, and S3 for centralized monitoring and logging  
   - Bootstraps Kubernetes add-ons (FluxCD, ArgoCD, Istio, Prometheus, Grafana)  

2. **GitOps Continuous Delivery (FluxCD & ArgoCD)**  
   - FluxCD monitors the Git repository for changes in manifests or Helm releases  
   - ArgoCD provides a visual dashboard to manage and sync Kubernetes workloads  
   - Application deployments are fully automated and version-controlled via Git  

3. **Service Mesh & Traffic Management (Istio)**  
   - Enables secure service-to-service communication with mTLS and policies  
   - Supports canary and blue/green deployments  
   - Provides detailed metrics and traces integrated with Prometheus and Grafana  

4. **Monitoring & Observability**  
   - Metrics collected via Prometheus and visualized in Grafana dashboards  
   - Centralized logs available in CloudWatch and OpenSearch  
   - Real-time health, latency, and performance monitoring across all microservices  

## 🔐 Secrets Configuration

In Azure DevOps, set the following secrets in your Variable Group:

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`

## 📊 Architecture Diagram

![Architecture](architecture-diagram.png)
