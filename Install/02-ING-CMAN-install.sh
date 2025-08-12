# install ingress-nginx
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

helm install ingress-nginx ingress-nginx/ingress-nginx --namespace ingress-nginx --create-namespace
kubectl get pods -n ingress-nginx
kubectl get svc -n ingress-nginx

kubectl patch svc ingress-nginx-controller -p '{"spec": {"type": "LoadBalancer", "externalIPs":["192.168.0.100"]}}' -n ingress-nginx

# install cert-manager 1.14.1
helm repo add jetstack https://charts.jetstack.io --force-update
helm repo update

helm install cert-manager jetstack/cert-manager  --namespace cert-manager --create-namespace  --version v1.14.1  --set installCRDs=true
kubectl get po -n cert-manager
kubectl logs -n cert-manager deploy/cert-manager
