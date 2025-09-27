# ☁️ AWS + Datadog Lab — IaC com Terraform (Free Tier)

![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4?logo=terraform)
![AWS](https://img.shields.io/badge/Cloud-AWS-FF9900?logo=amazon-aws)
![Datadog](https://img.shields.io/badge/Monitoring-Datadog-632CA6?logo=datadog)
![License](https://img.shields.io/badge/license-MIT-green)

> 🚀 Laboratório prático de **Infraestrutura como Código (IaC)** com **Terraform**, implantando uma stack **AWS + Datadog** para monitoramento de instância EC2, logs e métricas — totalmente **elegível ao Free Tier**.

---

## 🧩 Visão Geral

Este projeto demonstra como:

- Provisionar infraestrutura AWS (VPC, EC2, IAM, CloudWatch) com Terraform  
- Configurar **Datadog Agent** e **Lambda Forwarder**  
- Coletar **métricas, logs e eventos em tempo real**  
- Criar um **Monitor de CPU** e **Dashboard no Datadog**  
- Usar **SSM Parameter Store** para armazenar segredos com segurança  

📘 Ideal para:
- Profissionais iniciando com **IaC**
- Laboratórios de **monitoramento cloud**
- Prática de **integração AWS ↔ Datadog**

---

## 🏗️ Arquitetura

```
AWS VPC
 ├── Subnet Pública (Free Tier)
 │    ├── EC2 (Amazon Linux 2)
 │    │    └── Datadog Agent
 │    └── CloudWatch Logs
 │         └── Lambda Forwarder (envia logs ao Datadog)
 │
 └── SSM Parameter Store (API Key Datadog)
```

> ✅ Todos os recursos são **Free Tier elegíveis** e podem ser destruídos com um único comando.

---

## 🧠 Estrutura do Projeto

| Arquivo | Função |
|----------|--------|
| `providers.tf` | Configura AWS e Datadog Providers |
| `variables.tf` | Variáveis de ambiente e credenciais |
| `terraform.tfvars.example` | Exemplo de configuração |
| `vpc.tf` | Rede VPC e Subnet pública |
| `ec2.tf` | EC2 com Datadog Agent |
| `iam-datadog.tf` | Permissões mínimas (IAM Roles) |
| `datadog.tf` | Integração com Datadog |
| `ssm.tf` | Armazena API Key no Parameter Store |
| `lambda-forwarder.tf` | Lambda que envia logs ao Datadog |
| `cloudwatch.tf` | Configuração de Logs e Subscrição |
| `monitors.tf` | Monitor CPU > 70% |
| `dashboard.tf` | Dashboard com métricas básicas |
| `scripts/install_datadog_agent.sh` | Instala o agente Datadog |
| `.github/workflows/terraform.yml` | Validação CI/CD |
| `outputs.tf` | IP da EC2 e URLs úteis |

---

## ⚙️ Pré-Requisitos

- ✅ Conta AWS (Free Tier ativa)  
- ✅ Conta Datadog (Free Plan)  
- ✅ Chave API Datadog  
- ✅ Terraform ≥ 1.6  
- ✅ AWS CLI configurado (`aws configure`)

---

## 🚀 Como Executar

### 1️⃣ Clone o repositório
```bash
git clone https://github.com/<seu-usuario>/terraform-datadog-lab.git
cd terraform-datadog-lab
```

### 2️⃣ Configure as variáveis
```bash
cp terraform.tfvars.example terraform.tfvars
```
Edite:
```hcl
aws_region = "us-east-1"
datadog_api_key = "sua_api_key_aqui"
```

> 💡 Dica: você pode armazenar a `datadog_api_key` no **SSM Parameter Store** automaticamente.

---

### 3️⃣ Inicialize e valide
```bash
terraform init
terraform fmt
terraform validate
```

### 4️⃣ Planeje e aplique
```bash
terraform plan -out plan.out
terraform apply "plan.out"
```

---

### 5️⃣ Verifique no Datadog

📍 **Acesse:**  
- **Dashboards** → verá um painel criado automaticamente  
- **Monitors** → alerta de CPU (ativado >70%)  
- **Infrastructure → Host Map** → sua EC2 aparecerá conectada  

---

### 6️⃣ Limpeza de Recursos
Ao concluir os testes, execute:
```bash
terraform destroy -auto-approve
```
> 🧹 Isso remove todos os recursos e evita custos fora do Free Tier.

---

## 📊 O que é Monitorado

- ✅ CPU Usage  
- ✅ Memory Usage  
- ✅ Disk Space  
- ✅ System Uptime  
- ✅ CloudWatch Logs (via Lambda Forwarder)

---

## 🔐 Segurança e Boas Práticas

- 🔸 Nenhuma credencial é salva no código  
- 🔸 API Key Datadog armazenada no **AWS SSM Parameter Store**  
- 🔸 Roles e Policies aplicadas com **princípio do menor privilégio**  
- 🔸 Pipeline CI valida sintaxe antes do `apply`

---

## 🧠 Conceitos Praticados

| Tema | Aprendizado |
|------|--------------|
| **IaC** | Automação e versionamento de infraestrutura |
| **Observabilidade** | Coleta e visualização de métricas |
| **Segurança** | Segredos no SSM e IAM mínimo |
| **CI/CD Terraform** | Validação automática via GitHub Actions |
| **Free Tier AWS** | Otimização de custos e recursos elegíveis |

---

## 🧰 Tecnologias Utilizadas

- **Terraform** (IaC)
- **AWS** (EC2, VPC, IAM, SSM, CloudWatch)
- **Datadog** (Monitoramento e Logs)
- **GitHub Actions** (CI/CD)

---

## 🧑‍💻 Autor

**Eder Augusto Cintra Luccas**  
Profissional em transição para Cloud & FinOps  
[Credly Profile](https://www.credly.com/users/eder-luccas) | [LinkedIn](https://www.linkedin.com/in/eder-augusto-cintra-luccas)

---

## 🪪 Licença

Este projeto está sob a licença MIT — veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---
