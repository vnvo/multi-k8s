docker build -t thek33per/multi-client:latest -t thek33per/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t thek33per/multi-server:latest -t thek33per/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t thek33per/multi-worker:latest -f thek33per/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push thk33per/multi-client:latest
docker push thk33per/multi-server:latest
docker push thk33per/multi-worker:latest
docker push thk33per/multi-client:$SHA
docker push thk33per/multi-server:$SHA
docker push thk33per/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=thek33per/multi-server:$SHA
kubectl set image deployments/client-deployment server=thek33per/multi-client:$SHA
kubectl set image deployments/worker-deployment server=thek33per/multi-worker:$SHA



