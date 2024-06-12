# Clear unused images and volumes
# docker rmi $(docker images --quiet --filter "dangling=true")
# docker volume rm $(docker volume ls -qf dangling=true)

echo '########## Cleaning everything (docker images, volumes, everything...) ##########'
sleep 2s
docker rm -vf $(docker ps -a -q) 
docker system prune --all 
docker volume prune --filter all=1
sleep 2s

echo '########## creating ca materials for Laptop 1 ##########'
sleep 2s
cd ./setup1/Laptop1
sudo rm -rf crypto-config
sleep 1s
cd ./create-certificate-with-ca
sudo rm -rf fabric-ca
docker-compose up -d
sudo chmod 777 *
sleep 1s
./create-certificate-with-ca.sh
cd ../../

echo '########## creating ca materials for Laptop 2 ##########'
sleep 2s
cd ./Laptop2
sudo rm -rf crypto-config
sleep 1s
cd ./create-certificate-with-ca
sudo rm -rf fabric-ca
docker-compose up -d
sudo chmod 777 *
sleep 1s
./create-certificate-with-ca.sh
cd ../../

echo '########## creating ca materials for Pi 4 ##########'
sleep 2s
cd ./Pi4
sudo rm -rf crypto-config
sleep 1s
cd ./create-certificate-with-ca
sudo rm -rf fabric-ca
docker-compose up -d
sudo chmod 777 *
sleep 1s
./create-certificate-with-ca.sh
cd ../../

echo '########## creating ca materials for Pi 5 ##########'
sleep 2s
cd ./Pi5
sudo rm -rf crypto-config
sleep 1s
cd ./create-certificate-with-ca
sudo rm -rf fabric-ca
docker-compose up -d
sudo chmod 777 *
sleep 1s
./create-certificate-with-ca.sh
cd ../../

# echo '########## show all running containers ##########'
# docker ps

# echo '########## bootstrap the blockchain, creating genesis block and anchor peers ##########'
# cd ../artifacts/channel
# rm genesis.block
# rm mainchannel.tx
# rm Org1MSPanchors.tx
# rm Org2MSPanchors.tx
# rm Org3MSPanchors.tx
# ./create-artifacts.sh

# echo '########## running all peer and orderer containers ##########'
# cd ../../setup1/Laptop1
# docker-compose up -d

# cd ../Laptop\ 2
# docker-compose up -d

# cd ../Pi\ 4
# docker-compose up -d

# cd ../Pi\ 5
# docker-compose up -d