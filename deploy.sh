docker build -t omeraslam/multi-client:latest -t omeraslam/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t omeraslam/multi-server:latest -t omeraslam/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t omeraslam/multi-worker:latest -t omeraslam/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push omeraslam/multi-client:latest
docker push omeraslam/multi-server:latest
docker push omeraslam/multi-worker:latest

docker push omeraslam/multi-client:$SHA
docker push omeraslam/multi-server:$SHA
docker push omeraslam/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=omeraslam/multi-server:$SHA
kubectl set image deployments/client-deployment client=omeraslam/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=omeraslam/multi-worker:$SHA
