# Terraform : Baremetal Server infra 구축

## 01. Terraform 사용 환경 세팅
### 1) terraform 설치
**아래 링크에서 local 환경에 맞는 version을 선택하여 terraform을 설치해야 함.**
- [Terraform install](https://developer.hashicorp.com/terraform/downloads?product_intent=terraform)
- window 에서는 다운로드 후, 폴더에 `terraform.exe` 파일을 집어넣고 **시스템 환경변수 편집** 에서 새로운 환경변수로 등록해주면 됨.
- 설치 확인을 위한 명령어 : `terraform -version`  
    ![](./source/png/terraform-install.png)   

### 2) tf file 다운로드 (ver0.2)
- terraform 으로 생성되는 리소스  
    1. VPC
    2. BM Subnet
    3. NAT
    4. pem key
    5. Baremetal server group (default 1개)
