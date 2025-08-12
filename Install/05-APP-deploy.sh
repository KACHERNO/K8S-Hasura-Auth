kubectl create namespace demo

kubectl create deployment hello-world --image=nginx -n demo
kubectl expose deployment hello-world --port=80 --type=ClusterIP -n demo

kubectl create deployment web1 --image=gcr.io/google-samples/hello-app:1.0 -n demo
kubectl expose deployment web1 --type=NodePort --port=8080 -n demo

kubectl create deployment web2 --image=gcr.io/google-samples/hello-app:2.0 -n demo
kubectl expose deployment web2 --type=NodePort --port=8080 -n demo
