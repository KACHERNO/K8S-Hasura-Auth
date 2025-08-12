#
# Установка кластера kubernetes на физический сервер (BARE METAL)
# Исходное состояние - стандартная установка Ubuntu Server LTS 24.04
#

#
# Изменение hostname
#

sudo hostnamectl set-hostname k8s.kacherno.ru
echo "192.168.0.100 k8s.kacherno.ru k8s" | sudo tee -a /etc/hosts

sudo systemctl restart systemd-hostnamed

#
# Отключение SWAP (закоментировать /swap в /etc/fstab)
#

sudo swapoff -a

#
# Обязательные модули
#

sudo tee /etc/modules-load.d/containerd.conf <<EOF
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter
sudo lsmod

#
# Обязательные сетевые настройки
#

sudo tee /etc/sysctl.d/kubernetes.conf <<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

sudo sysctl --system


#
# Установка и настройка containerd
#

# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt install ca-certificates curl apt-transport-https software-properties-common
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu noble stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y curl gnupg2
sudo apt install -y software-properties-common apt-transport-https ca-certificates
sudo apt install -y containerd.io

containerd config default | sudo tee /etc/containerd/config.toml >/dev/null 2>&1
#            SystemdCgroup = true

sudo systemctl restart containerd
sudo systemctl enable containerd


#
# Установка kubernetes
#

# sudo curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
# echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
# sudo apt update

sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt update
sudo apt install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl


# Your Kubernetes control-plane has initialized successfully!
# To start using your cluster, you need to run the following as a regular user:


#
# Настройка локального окружения
#

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl cluster-info

#
# Установка flannel в kubernetes-кластер
#

kubectl apply -f "https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml"
kubectl get pods -n kube-system

#
# Разрешение для control-plane-ноды быть worker-нодой
#

kubectl taint nodes --all node-role.kubernetes.io/control-plane-
