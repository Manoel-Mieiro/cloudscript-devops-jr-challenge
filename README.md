# CloudScript Technology DevOps Challenge

Trata-se de um projeto de **Infraestrutura como Código (IaC)** para implantação de **Amazon EKS** e **VPC** funcionais utilizando **Terraform**.  
Os detalhes do desafio podem ser conferidos em [challenge.md](./challenge.md).



## Visão geral da solução

O presente projeto busca implementar um **Elastic Kubernetes Service (EKS)** em uma **Virtual Private Cloud (VPC)** dedicada, utilizando **Terraform** e módulos oficiais da AWS.

A solução foi estruturada adotando **múltiplos states**, separados por responsabilidade, seguindo boas práticas de organização, segurança e governança de infraestrutura. Essa abordagem reduz o acoplamento entre recursos, facilita a manutenção e permite que diferentes camadas da infraestrutura evoluam de forma independente.

Para esse projeto foi escolhida uma abordagem de **backend** local para cada camada, isso é, os **states**. No entanto, é uma boa prática utilizar **backend** remoto, o que pode ser alcançado com o seguinte _snippet_ ([fonte](https://developer.hashicorp.com/terraform/language/backend/s3)):

```tf
terraform {
  backend "s3" {
    bucket = "mybucket"
    key    = "path/to/my/key"
    region = "us-east-1"
  }
}
```

Fora isso, foi adotada a criação de um **usuário IAM dedicado**, com permissões controladas via **policies gerenciadas da AWS**, evitando o uso contínuo do usuário **root** e aplicando o princípio do **menor privilégio**.



## Explicação da arquitetura

A arquitetura proposta utiliza serviços gerenciados da **Amazon Web Services** e é provisionada integralmente via Terraform, seguindo princípios de infraestrutura como código, segurança por padrão e otimização de custos.

A base da solução é uma **Virtual Private Cloud (VPC)** dedicada, responsável por isolar e segmentar os recursos de rede. Dentro dessa VPC são criadas **subnets privadas**, onde residem os **nodes** do cluster Kubernetes, garantindo que as cargas de trabalho não fiquem diretamente expostas à internet.

Sobre essa VPC é implantado um **cluster Amazon Elastic Kubernetes Service (EKS)**, responsável pelo plano de controle do Kubernetes. O **Control Plane é gerenciado pela AWS**, reduzindo o esforço operacional e aumentando a confiabilidade da solução. Para fins de simplicidade no desafio, o **endpoint da API do Kubernetes é configurado como público**, permitindo o uso do `kubectl` a partir da máquina local.

Os **managed node groups** do EKS utilizam instâncias **EC2 com Amazon Linux 2023**, em modo **ON_DEMAND**, equilibrando compatibilidade, custo e previsibilidade. Esses nodes são criados exclusivamente em **subnets privadas**, reforçando o isolamento das aplicações.

O acesso externo às aplicações executadas no cluster não ocorre diretamente pelo endpoint do EKS, mas sim por meio de **recursos Kubernetes**, como **Services do tipo LoadBalancer** ou **Ingress**, que, quando configurados, provisionam automaticamente **load balancers gerenciados pela AWS**.

O controle de acesso à infraestrutura é realizado via **IAM**, utilizando usuários, roles e policies específicas. O uso do usuário root é restrito apenas ao **bootstrap inicial**, sendo substituído por um usuário IAM dedicado para todas as operações posteriores.

O diagrama **C4** correspondente à arquitetura da solução pode ser observado na figura a seguir:

![Arquitetura](./media/cloudscript.png)



## Estrutura de diretórios e States

A infraestrutura foi dividida em **múltiplos states**, organizados por responsabilidade:

```text
.
├── iam/         # Usuários, policies e bindings IAM
│   └── terraform.tfstate
├── infra/       # VPC, EKS, Node Groups e recursos base
│   └── terraform.tfstate
├── platform/    # Kubernetes, Helm, Ingress e workloads
│   └── terraform.tfstate
└── values.tfvars
```

Essa separação permite:

- Execução independente por domínio

- Redução de impacto em mudanças

- Melhor controle de acesso por camada

- Clareza na responsabilidade de cada state

## Execução do Terraform

### Pré-requisitos

-Terraform instalado e disponível no PATH

- AWS CLI configurada

- Credenciais válidas na AWS

Verifique a instalação do Terraform com:

```sh
terraform -v
```

### Ordem de execução

1. IAM – Bootstrap inicial

Importante

```text
A primeira execução deve ser realizada utilizando o usuário root, que já possui a policy AdministratorAccess atribuída via console AWS.
```

Nesta etapa são criados:

- Usuário IAM dedicado ao laboratório

- Attach das policies gerenciadas necessárias para provisionar VPC, EKS, EC2 e demais recursos

Execução:

```sh
cd iam
terraform init
terraform plan
terraform apply
```

Após essa etapa:

Configure o novo profile, `vasya.pupkin`, AWS apontando para o usuário criado

Interrompa o uso do usuário `root`

Exemplo:

```sh
aws configure --profile vasya.pupkin
export AWS_PROFILE=vasya.pupkin
```

2. Infra – VPC e EKS
   Esta camada é responsável pela infraestrutura base:

- VPC
- Subnets públicas e privadas
- EKS
- Managed Node Groups

Execução:

```sh
cd infra
terraform init
terraform plan -var-file="../values.tfvars" -out=plan.tfplan
terraform apply plan.tfplan
```

3. Platform – Kubernetes e Helm
   Esta camada é responsável pela plataforma Kubernetes, incluindo:

- Provider Kubernetes
- Provider Helm
- Ingress Controller (NGINX)
- Exposição de serviços via Ingress

A ideia desta camada é expor aplicações rodando no cluster, utilizando recursos Kubernetes e charts Helm padronizados.

Execução:

```sh
cd platform
terraform init
terraform plan -var-file="../values.tfvars" -out=plan.tfplan
terraform apply plan.tfplan
```

## Dentro do Cluster

Após a criação do EKS, é necessário atualizar o contexto do kubeconfig utilizando o profile do usuário administrador criado (`vasya.pupkin`):

```sh
aws eks update-kubeconfig \
  --name eks-cloudscript-dsv \
  --region us-west-2 \
  --profile vasya.pupkin
```

Validação do acesso ao cluster:

```sh
kubectl get node
kubectl get pods -A
```

Comprovação:
![image](./media/pods.png)

## Decisões técnicas

- Uso de módulos oficiais da AWS para VPC e EKS
- Separação de states por responsabilidade
- Node Groups com Amazon Linux 2023
- Capacidade ON_DEMAND para previsibilidade de custos
- Uso de Helm para padronizar componentes de plataforma
- Controle de arquivos sensíveis via .gitignore
- Exclusão da infraestrutura ao final do laboratório com terraform destroy

## Melhorias identificadas

- Uso de backend remoto com S3
- Granularização mais fina de policies IAM
- API do EKS privada
- Acesso via VPN ou Bastion Host
- Pipeline CI/CD para execução automática de plan e apply
