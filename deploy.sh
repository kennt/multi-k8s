docker build -t islandboy83/book3-client:latest -t islandboy83/book3-client:$SHA -f ./client/Dockerfile ./client
docker build -t islandboy83/book3-server:latest -t islandboy83/book3-server:$SHA -f ./server/Dockerfile ./server
docker build -t islandboy83/book3-worker:latest -t islandboy83/book3-worker:$SHA -f ./worker/Dockerfile ./worker

docker push islandboy83/book3-client:latest
docker push islandboy83/book3-server:latest
docker push islandboy83/book3-worker:latest
docker push islandboy83/book3-client:$SHA
docker push islandboy83/book3-server:$SHA
docker push islandboy83/book3-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=islandboy83/book3-server:$SHA
kubectl set image deployments/client-deployment client=islandboy83/book3-client:$SHA
kubectl set image deployments/worker-deployment worker=islandboy83/book3-worker:$SHA

