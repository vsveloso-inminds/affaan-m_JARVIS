#!/usr/bin/env bash
# Provisiona a VM de laboratorio do JARVIS na Azure (DT-004).
#
# Cria um resource group proprio, uma VM Ubuntu 22.04 com Docker, abre so as
# portas necessarias e agenda desligamento automatico as 23:00 (Brasilia) para
# nao queimar credito. Idempotente: rodar de novo nao duplica nada.
#
# Uso:
#   bash scripts/lab/provision-azure-vm.sh                # defaults abaixo
#   LAB_ALLOWED_IP=200.1.2.3 bash scripts/lab/provision-azure-vm.sh
#
# Depois, na VM:
#   ssh azureuser@<ip>
#   cd ~/jarvis && cp .env.lab.example .env.lab && nano .env.lab
#   docker compose -f docker-compose.lab.yml --env-file .env.lab up -d --build
#
# Desligar quando nao usar (so paga disco):
#   az vm deallocate -g rg-inminds-jarvis-lab -n vm-jarvis-lab
# Religar:
#   az vm start -g rg-inminds-jarvis-lab -n vm-jarvis-lab

set -euo pipefail

LAB_RG="${LAB_RG:-rg-inminds-jarvis-lab}"
LAB_LOCATION="${LAB_LOCATION:-brazilsouth}"
LAB_VM="${LAB_VM:-vm-jarvis-lab}"
LAB_SIZE="${LAB_SIZE:-Standard_B4ms}"          # 4 vCPU, 16 GB. torch + mediapipe + build do Next cabem
LAB_DISK_GB="${LAB_DISK_GB:-64}"
LAB_USER="${LAB_USER:-azureuser}"
LAB_REPO="${LAB_REPO:-https://github.com/vsveloso-inminds/affaan-m_JARVIS}"
LAB_ALLOWED_IP="${LAB_ALLOWED_IP:-*}"          # IP de origem permitido em 22/3000/8000. '*' = qualquer
LAB_SHUTDOWN_UTC="${LAB_SHUTDOWN_UTC:-0200}"   # 23:00 em Brasilia (UTC-3)
LAB_SHUTDOWN_EMAIL="${LAB_SHUTDOWN_EMAIL:-vitor.veloso@inminds.com.br}"

TAGS="projeto=jarvis ambiente=lab dono=vitor.veloso decisao=DT-004"

# Assinatura: "Microsoft Partner Success Core Benefits". A MPSCB 20261023 esta em
# estado Warned (somente leitura) desde pelo menos 2026-10-30 e falha com
# ReadOnlyDisabledSubscription.
LAB_SUBSCRIPTION="${LAB_SUBSCRIPTION:-85ca7304-59e2-42e8-bd77-077767783e96}"
echo ">> Assinatura $LAB_SUBSCRIPTION"
az account set -s "$LAB_SUBSCRIPTION"

echo ">> Resource group $LAB_RG em $LAB_LOCATION"
az group create -n "$LAB_RG" -l "$LAB_LOCATION" --tags $TAGS -o none

CLOUD_INIT="$(mktemp)"
cat > "$CLOUD_INIT" <<EOF
#cloud-config
package_update: true
package_upgrade: true
packages: [ca-certificates, curl, git, gnupg]
runcmd:
  - install -m 0755 -d /etc/apt/keyrings
  - curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  - chmod a+r /etc/apt/keyrings/docker.asc
  - echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu jammy stable" > /etc/apt/sources.list.d/docker.list
  - apt-get update
  - apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  - usermod -aG docker $LAB_USER
  - sudo -u $LAB_USER git clone $LAB_REPO /home/$LAB_USER/jarvis
  - sudo -u $LAB_USER cp /home/$LAB_USER/jarvis/.env.lab.example /home/$LAB_USER/jarvis/.env.lab
  - echo "JARVIS lab pronto. Preencher ~/jarvis/.env.lab e subir o compose." > /etc/motd
EOF

if az vm show -g "$LAB_RG" -n "$LAB_VM" -o none 2>/dev/null; then
  echo ">> VM $LAB_VM ja existe, pulando criacao"
else
  echo ">> Criando VM $LAB_VM ($LAB_SIZE, ${LAB_DISK_GB} GB)"
  az vm create \
    -g "$LAB_RG" -n "$LAB_VM" -l "$LAB_LOCATION" \
    --image Ubuntu2204 --size "$LAB_SIZE" \
    --os-disk-size-gb "$LAB_DISK_GB" --storage-sku StandardSSD_LRS \
    --admin-username "$LAB_USER" --generate-ssh-keys \
    --public-ip-sku Standard --nsg-rule NONE \
    --custom-data "$CLOUD_INIT" \
    --tags $TAGS -o none
fi
rm -f "$CLOUD_INIT"

NSG="${LAB_VM}NSG"
echo ">> Regras de rede (origem: $LAB_ALLOWED_IP)"
prio=1000
for porta in 22 3000 8000; do
  az network nsg rule create -g "$LAB_RG" --nsg-name "$NSG" -n "allow-$porta" \
    --priority $prio --access Allow --protocol Tcp --direction Inbound \
    --source-address-prefixes "$LAB_ALLOWED_IP" --destination-port-ranges "$porta" -o none 2>/dev/null \
  || az network nsg rule update -g "$LAB_RG" --nsg-name "$NSG" -n "allow-$porta" \
    --source-address-prefixes "$LAB_ALLOWED_IP" -o none
  prio=$((prio+10))
done

echo ">> Desligamento automatico as ${LAB_SHUTDOWN_UTC} UTC"
az vm auto-shutdown -g "$LAB_RG" -n "$LAB_VM" --time "$LAB_SHUTDOWN_UTC" --email "$LAB_SHUTDOWN_EMAIL" -o none

IP="$(az vm show -d -g "$LAB_RG" -n "$LAB_VM" --query publicIps -o tsv)"
echo
echo "VM de lab pronta."
echo "  ssh $LAB_USER@$IP"
echo "  frontend: http://$IP:3000   backend: http://$IP:8000/api/health"
echo "  cloud-init leva 2 a 4 min para instalar Docker e clonar o repo. Acompanhar: sudo cloud-init status --wait"
echo "  Para o build do frontend, defina em .env.lab: NEXT_PUBLIC_API_URL=http://$IP:8000 e JARVIS_FRONTEND_ORIGIN=http://$IP:3000"
