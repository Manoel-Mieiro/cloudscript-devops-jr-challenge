# CloudScript Technology DevOps Challenge

Trata-se de um projeto de IaC para implantação de EKS e VPC funcionais. Os detalhes do projeto podem ser conferidos em [challenge.md](./challenge.md).

## Visão geral da solução

## Explicação da arquitetura

## Execução do Terraform
Deve-se fazer a instalação do Terraform na máquina e adicioná-lo às variáveis de ambiente `PATH`. Feito isso, pode-se conferir após o _reboot_ que o comando abaixo reconhece o cmdlet `terraform`:

```sh
terraform -v
Terraform v1.14.3
on windows_386
+ provider registry.terraform.io/hashicorp/aws v6.28.0
+ provider registry.terraform.io/hashicorp/cloudinit v2.3.7
+ provider registry.terraform.io/hashicorp/null v3.2.4
+ provider registry.terraform.io/hashicorp/time v0.13.1
+ provider registry.terraform.io/hashicorp/tls v4.1.0
```

Após isso, pode-se fazer uma cópia do arquivo [values](./values.tfvars.example) de exemplo, removendo a extensão `.example`, ficando portanto `values.tfvars`. De posse do arquivo de valores, deve-se inserir seus próprios valores e salvá-lo.

### Criando State e Baixando Módulos
Para iniciar a provisão, execute o comando de init abaixo:
```sh
terraform init
```
Dessa forma, os módulos remotos serão baixados e o arquivo de `state` será criado no `backend`. Sobre esse último componente, optou-se pela abordagem local, para não ter de criar um Bucket S3 e arcar com eventuais custos. No entanto, é uma boa prática utilizar `remote state`, o que pode ser alcançado com o seguinte _snippet_ ([fonte](https://developer.hashicorp.com/terraform/language/backend/s3)):

```tf
terraform {
  backend "s3" {
    bucket = "mybucket"
    key    = "path/to/my/key"
    region = "us-east-1"
  }
}
```

### Executando Plan e Dependências
Antes de executar o `terraform apply`, por mais que ele já faça um `plan`, é boa prática verificar as mudanças na infraestrutura com o terraform plan. Como estamos usando um arquivo `.tfvars`, deve-se utilizar o argumento `var-file` para especificar nosso arquivo. Para esse caso, utilizei também a opção `-out` para exportar o plan como arquivo `.tfplan`. O comando descrito está disposto no _snippet_ a seguir:

```sh
terraform plan -var-file="./values.tvars" -out="plan.tfplan"
```

Esse arquivo pode ser tranformado em texto (`.txt`) para leitura posterior utilizando o comando abaixo:

```sh
terraform show -no-color plan.tfplan
```

Agora sobre as dependências, temos que o módulo `EKS` precisa da resolução de valores oriundos da `VPC`, então deve-se provisioná-lo após a criação desse recurso. Por estarmos usando módulos não há diretiva `depends_on`, o que é um problema. Nesse cenário, pode-se executar o `plan` ou `apply` utilizando o argumento `target` ou fazer o `enforce` com os valores de `output` do módulo `VPC`.

## Decisões técnicas
- Uso dos módulos `VPC` e `EKS` para provisão da infraestrutura;
- Controle de arquivos sensíveis usando o `.gitignore`;
- Adoção de node group `AL2023_x86_64_STANDARD `, com capacidade `ON_DEMAND` para otimização dos custos;
- Uso do `terraform destroy` ao final do laboratório para exclusão da infraestrutura;
- Acesso ao `endpoint` kubernetes público, para uso do `kubectl` na máquina local;
- 


## Melhorias Identificadas
- Granularidade de acesso utilizando IAM `roles` para provisão, acesso e exclusão da infraestrutura;
- Segurança do Kubernetes, tornando sua API privada e fazendo acesso por `VPN` ou `Bastion`.