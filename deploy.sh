docker build -t inthrakumarp/multi-client:latest -t inthrakumarp/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t inthrakumarp/multi-server:latest -t inthrakumarp/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t inthrakumarp/multi-worker:latest -t inthrakumarp/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push inthrakumarp/multi-client:latest
docker push inthrakumarp/multi-server:latest
docker push inthrakumarp/multi-worker:latest

docker push inthrakumarp/multi-client:$SHA
docker push inthrakumarp/multi-server:$SHA
docker push inthrakumarp/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=inthrakumarp/multi-server:$SHA
kubectl set image deployments/client-deployment client=inthrakumarp/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=inthrakumarp/multi-worker:$SHA