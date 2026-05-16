# k8s-learn

# I started with initialization of ingress controller
helm install ingress-nginx ingress-nginx/ingress-nginx --namespace ingress-nginx --create-namespace --set controller.replicaCount=1 --set controller.service.type=LoadBalancer --set controller.image.registry=registry.k8s.io --set controller.image.image=ingress-nginx/controller --set controller.image.tag=v1.15.1 --set controller.image.digest="" --set controller.image.pullPolicy=IfNotPresent --wait --timeout 2m --debug --set controller.admissionWebhooks.patch.image.registry=registry.k8s.io --set controller.admissionWebhooks.patch.image.image=ingress-nginx/kube-webhook-certgen --set controller.admissionWebhooks.patch.image.tag=v1.6.9 --set controller.admissionWebhooks.patch.image.digest="" --set controller.admissionWebhooks.patch.image.pullPolicy=IfNotPresent

# Checking that ingress controller is ready
wsl kubectl get svc -n=ingress-nginx                                                              
NAME                                  TYPE           CLUSTER-IP       EXTERNAL-IP   PORT(S)                      AGE                                
my-ingress-ingress-nginx-controller   LoadBalancer   10.107.105.177   127.0.0.1     80:31106/TCP,443:30553/TCP   23s

# applying ingress
wsl helm upgrade k8s k8s

# exposing minikube resources to localhost
wsl minikube tunnel

# calling resource service by ingress routing
wsl curl -i http://localhost/api/v1/resource-service/actuator/health
HTTP/1.1 200
Date: Sat, 16 May 2026 07:07:57 GMT
Content-Type: application/vnd.spring-boot.actuator.v3+json
Transfer-Encoding: chunked
Connection: keep-alive

{"status":"UP","groups":["liveness","readiness"]}

# calling song service by ingress routing
wsl curl -i http://localhost/api/v1/song-service/actuator/health
HTTP/1.1 200
Date: Sat, 16 May 2026 07:08:24 GMT
Content-Type: application/vnd.spring-boot.actuator.v3+json
Transfer-Encoding: chunked
Connection: keep-alive

{"status":"UP","groups":["liveness","readiness"]}
