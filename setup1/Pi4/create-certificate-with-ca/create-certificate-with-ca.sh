createcertificatesForPi4() {
  echo
  echo "Enroll the CA admin"
  echo
  mkdir -p ../crypto-config/peerOrganizations/pi4/
  export FABRIC_CA_CLIENT_HOME=${PWD}/../crypto-config/peerOrganizations/pi4/

  fabric-ca-client enroll -u https://admin:adminpw@localhost:10054 --caname ca.pi4 --tls.certfiles ${PWD}/fabric-ca/pi4/tls-cert.pem

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-10054-ca-pi4.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-10054-ca-pi4.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-10054-ca-pi4.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-10054-ca-pi4.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/../crypto-config/peerOrganizations/pi4/msp/config.yaml

  echo
  echo "Register peer0"
  echo
  fabric-ca-client register --caname ca.pi4 --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/fabric-ca/pi4/tls-cert.pem

  echo
  echo "Register peer1"
  echo
  fabric-ca-client register --caname ca.pi4 --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles ${PWD}/fabric-ca/pi4/tls-cert.pem

  echo
  echo "Register user"
  echo
  fabric-ca-client register --caname ca.pi4 --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/fabric-ca/pi4/tls-cert.pem

  echo
  echo "Register the org admin"
  echo
  fabric-ca-client register --caname ca.pi4 --id.name pi4admin --id.secret pi4adminpw --id.type admin --tls.certfiles ${PWD}/fabric-ca/pi4/tls-cert.pem

  mkdir -p ../crypto-config/peerOrganizations/pi4/peers

  # -----------------------------------------------------------------------------------
  #  Peer 0
  mkdir -p ../crypto-config/peerOrganizations/pi4/peers/peer0.pi4

  echo
  echo "## Generate the peer0 msp"
  echo
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:10054 --caname ca.pi4 -M ${PWD}/../crypto-config/peerOrganizations/pi4/peers/peer0.pi4/msp --csr.hosts peer0.pi4 --tls.certfiles ${PWD}/fabric-ca/pi4/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/pi4/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/pi4/peers/peer0.pi4/msp/config.yaml

  echo
  echo "## Generate the peer0-tls certificates"
  echo
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:10054 --caname ca.pi4 -M ${PWD}/../crypto-config/peerOrganizations/pi4/peers/peer0.pi4/tls --enrollment.profile tls --csr.hosts peer0.pi4 --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/pi4/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/pi4/peers/peer0.pi4/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/pi4/peers/peer0.pi4/tls/ca.crt
  cp ${PWD}/../crypto-config/peerOrganizations/pi4/peers/peer0.pi4/tls/signcerts/* ${PWD}/../crypto-config/peerOrganizations/pi4/peers/peer0.pi4/tls/server.crt
  cp ${PWD}/../crypto-config/peerOrganizations/pi4/peers/peer0.pi4/tls/keystore/* ${PWD}/../crypto-config/peerOrganizations/pi4/peers/peer0.pi4/tls/server.key

  mkdir ${PWD}/../crypto-config/peerOrganizations/pi4/msp/tlscacerts
  cp ${PWD}/../crypto-config/peerOrganizations/pi4/peers/peer0.pi4/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/pi4/msp/tlscacerts/ca.crt

  mkdir ${PWD}/../crypto-config/peerOrganizations/pi4/tlsca
  cp ${PWD}/../crypto-config/peerOrganizations/pi4/peers/peer0.pi4/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/pi4/tlsca/tlsca.pi4-cert.pem

  mkdir ${PWD}/../crypto-config/peerOrganizations/pi4/ca
  cp ${PWD}/../crypto-config/peerOrganizations/pi4/peers/peer0.pi4/msp/cacerts/* ${PWD}/../crypto-config/peerOrganizations/pi4/ca/ca.pi4-cert.pem

  # ------------------------------------------------------------------------------------------------

  # Peer1

  mkdir -p ../crypto-config/peerOrganizations/pi4/peers/peer1.pi4

  echo
  echo "## Generate the peer1 msp"
  echo
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:10054 --caname ca.pi4 -M ${PWD}/../crypto-config/peerOrganizations/pi4/peers/peer1.pi4/msp --csr.hosts peer1.pi4 --tls.certfiles ${PWD}/fabric-ca/pi4/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/pi4/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/pi4/peers/peer1.pi4/msp/config.yaml

  echo
  echo "## Generate the peer1-tls certificates"
  echo
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:10054 --caname ca.pi4 -M ${PWD}/../crypto-config/peerOrganizations/pi4/peers/peer1.pi4/tls --enrollment.profile tls --csr.hosts peer1.pi4 --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/pi4/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/pi4/peers/peer1.pi4/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/pi4/peers/peer1.pi4/tls/ca.crt
  cp ${PWD}/../crypto-config/peerOrganizations/pi4/peers/peer1.pi4/tls/signcerts/* ${PWD}/../crypto-config/peerOrganizations/pi4/peers/peer1.pi4/tls/server.crt
  cp ${PWD}/../crypto-config/peerOrganizations/pi4/peers/peer1.pi4/tls/keystore/* ${PWD}/../crypto-config/peerOrganizations/pi4/peers/peer1.pi4/tls/server.key

  # --------------------------------------------------------------------------------------------------

  mkdir -p ../crypto-config/peerOrganizations/pi4/users
  mkdir -p ../crypto-config/peerOrganizations/pi4/users/User1@pi4

  echo
  echo "## Generate the user msp"
  echo
  fabric-ca-client enroll -u https://user1:user1pw@localhost:10054 --caname ca.pi4 -M ${PWD}/../crypto-config/peerOrganizations/pi4/users/User1@pi4/msp --tls.certfiles ${PWD}/fabric-ca/pi4/tls-cert.pem

  mkdir -p ../crypto-config/peerOrganizations/pi4/users/Admin@pi4

  echo
  echo "## Generate the org admin msp"
  echo
  fabric-ca-client enroll -u https://pi4admin:pi4adminpw@localhost:10054 --caname ca.pi4 -M ${PWD}/../crypto-config/peerOrganizations/pi4/users/Admin@pi4/msp --tls.certfiles ${PWD}/fabric-ca/pi4/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/pi4/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/pi4/users/Admin@pi4/msp/config.yaml

}

createcertificatesForPi4

