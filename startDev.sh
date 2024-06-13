# Clear unused images and volumes
# docker rmi $(docker images --quiet --filter "dangling=true")
# docker volume rm $(docker volume ls -qf dangling=true)

echo
echo
echo '########## Cleaning everything (docker images, volumes, everything...) ##########'
sleep 2s
docker rm -vf $(docker ps -a -q) 
docker system prune --all 
docker volume prune --filter all=1
sleep 2s

echo
echo
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

echo
echo
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

echo
echo
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

echo 
echo
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

echo
echo
echo '########## show all running containers ##########'
docker ps

echo
echo
echo '########## bootstrap the blockchain, creating genesis block and anchor peers ##########'
cd ../artifacts/channel
rm genesis.block
rm mainchannel.tx
rm Laptop1MSPanchors.tx
rm Laptop2MSPanchors.tx
rm Pi4MSPanchors.tx
./create-artifacts.sh

echo
echo
echo '########## running Laptop 1 nodes ##########'
sleep 2s
cd ../../setup1/Laptop1
docker-compose up -d
sleep 2s

echo
echo
echo '########## running Laptop 2 nodes ##########'
sleep 2s
cd ../Laptop2
docker-compose up -d
sleep 2s

echo
echo
echo '########## show all running containers ##########'
docker ps

# cd ../Pi\ 4
# docker-compose up -d

# cd ../Pi\ 5
# docker-compose up -d