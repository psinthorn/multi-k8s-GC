docker build -t ecosyn1980/multi-client:latest -t ecosyn1980/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ecosyn1980/multi-server:latest -t ecosyn1980/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ecosyn1980/multi-worker:latest -t ecosyn1980/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ecosyn1980/multi-client:latest
docker push ecosyn1980/multi-server:latest
docker push ecosyn1980/multi-worker:latest

docker push ecosyn1980/multi-client:$SHA
docker push ecosyn1980/multi-server:$SHA
docker push ecosyn1980/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image ecosyn1980/client-deployment client=ecosyn1980/multi-client:$SHA
kubectl set image ecosyn1980/server-deployment server=ecosyn1980/multi-server:$SHA 
kubectl set image ecosyn1980/worker-deployment worker=ecosyn1980/multi-worker:$SHA