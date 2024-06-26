createcertificatesForLaptop1() {
  echo
  echo "Enroll the CA admin"
  echo
  mkdir -p ../crypto-config/peerOrganizations/laptop1/
  
  export FABRIC_CA_CLIENT_HOME=${PWD}/../crypto-config/peerOrganizations/laptop1/

  fabric-ca-client enroll -u https://admin:adminpw@localhost:7054 --caname ca.laptop1 --tls.certfiles ${PWD}/fabric-ca/laptop1/tls-cert.pem

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-laptop1.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-laptop1.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-laptop1.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-laptop1.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/../crypto-config/peerOrganizations/laptop1/msp/config.yaml

  echo
  echo "Register endorser1"
  echo
  fabric-ca-client register --caname ca.laptop1 --id.name endorser1 --id.secret endorser1pw --id.type peer --tls.certfiles ${PWD}/fabric-ca/laptop1/tls-cert.pem

  echo
  echo "Register endorser2"
  echo
  fabric-ca-client register --caname ca.laptop1 --id.name endorser2 --id.secret endorser2pw --id.type peer --tls.certfiles ${PWD}/fabric-ca/laptop1/tls-cert.pem

  echo
  echo "Register user"
  echo
  fabric-ca-client register --caname ca.laptop1 --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/fabric-ca/laptop1/tls-cert.pem

  echo
  echo "Register the org admin"
  echo
  fabric-ca-client register --caname ca.laptop1 --id.name laptop1admin --id.secret laptop1adminpw --id.type admin --tls.certfiles ${PWD}/fabric-ca/laptop1/tls-cert.pem

  mkdir -p ../crypto-config/peerOrganizations/laptop1/peers

  # -----------------------------------------------------------------------------------
  #  Peer 0
  mkdir -p ../crypto-config/peerOrganizations/laptop1/peers/endorser1.laptop1

  echo
  echo "## Generate the endorser1 msp"
  echo
  fabric-ca-client enroll -u https://endorser1:endorser1pw@localhost:7054 --caname ca.laptop1 -M ${PWD}/../crypto-config/peerOrganizations/laptop1/peers/endorser1.laptop1/msp --csr.hosts endorser1.laptop1 --tls.certfiles ${PWD}/fabric-ca/laptop1/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/laptop1/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/laptop1/peers/endorser1.laptop1/msp/config.yaml

  echo
  echo "## Generate the endorser1-tls certificates"
  echo
  fabric-ca-client enroll -u https://endorser1:endorser1pw@localhost:7054 --caname ca.laptop1 -M ${PWD}/../crypto-config/peerOrganizations/laptop1/peers/endorser1.laptop1/tls --enrollment.profile tls --csr.hosts endorser1.laptop1 --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/laptop1/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/laptop1/peers/endorser1.laptop1/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/laptop1/peers/endorser1.laptop1/tls/ca.crt
  cp ${PWD}/../crypto-config/peerOrganizations/laptop1/peers/endorser1.laptop1/tls/signcerts/* ${PWD}/../crypto-config/peerOrganizations/laptop1/peers/endorser1.laptop1/tls/server.crt
  cp ${PWD}/../crypto-config/peerOrganizations/laptop1/peers/endorser1.laptop1/tls/keystore/* ${PWD}/../crypto-config/peerOrganizations/laptop1/peers/endorser1.laptop1/tls/server.key

  mkdir ${PWD}/../crypto-config/peerOrganizations/laptop1/msp/tlscacerts
  cp ${PWD}/../crypto-config/peerOrganizations/laptop1/peers/endorser1.laptop1/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/laptop1/msp/tlscacerts/ca.crt

  mkdir ${PWD}/../crypto-config/peerOrganizations/laptop1/tlsca
  cp ${PWD}/../crypto-config/peerOrganizations/laptop1/peers/endorser1.laptop1/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/laptop1/tlsca/tlsca.laptop1-cert.pem

  mkdir ${PWD}/../crypto-config/peerOrganizations/laptop1/ca
  cp ${PWD}/../crypto-config/peerOrganizations/laptop1/peers/endorser1.laptop1/msp/cacerts/* ${PWD}/../crypto-config/peerOrganizations/laptop1/ca/ca.laptop1-cert.pem

  # ------------------------------------------------------------------------------------------------

  # endorser2

  mkdir -p ../crypto-config/peerOrganizations/laptop1/peers/endorser2.laptop1

  echo
  echo "## Generate the endorser2 msp"
  echo
  fabric-ca-client enroll -u https://endorser2:endorser2pw@localhost:7054 --caname ca.laptop1 -M ${PWD}/../crypto-config/peerOrganizations/laptop1/peers/endorser2.laptop1/msp --csr.hosts endorser2.laptop1 --tls.certfiles ${PWD}/fabric-ca/laptop1/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/laptop1/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/laptop1/peers/endorser2.laptop1/msp/config.yaml

  echo
  echo "## Generate the endorser2-tls certificates"
  echo
  fabric-ca-client enroll -u https://endorser2:endorser2pw@localhost:7054 --caname ca.laptop1 -M ${PWD}/../crypto-config/peerOrganizations/laptop1/peers/endorser2.laptop1/tls --enrollment.profile tls --csr.hosts endorser2.laptop1 --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/laptop1/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/laptop1/peers/endorser2.laptop1/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/laptop1/peers/endorser2.laptop1/tls/ca.crt
  cp ${PWD}/../crypto-config/peerOrganizations/laptop1/peers/endorser2.laptop1/tls/signcerts/* ${PWD}/../crypto-config/peerOrganizations/laptop1/peers/endorser2.laptop1/tls/server.crt
  cp ${PWD}/../crypto-config/peerOrganizations/laptop1/peers/endorser2.laptop1/tls/keystore/* ${PWD}/../crypto-config/peerOrganizations/laptop1/peers/endorser2.laptop1/tls/server.key

  # --------------------------------------------------------------------------------------------------

  mkdir -p ../crypto-config/peerOrganizations/laptop1/users
  mkdir -p ../crypto-config/peerOrganizations/laptop1/users/User1@laptop1

  echo
  echo "## Generate the user msp"
  echo
  fabric-ca-client enroll -u https://user1:user1pw@localhost:7054 --caname ca.laptop1 -M ${PWD}/../crypto-config/peerOrganizations/laptop1/users/User1@laptop1/msp --tls.certfiles ${PWD}/fabric-ca/laptop1/tls-cert.pem

  mkdir -p ../crypto-config/peerOrganizations/laptop1/users/Admin@laptop1

  echo
  echo "## Generate the org admin msp"
  echo
  fabric-ca-client enroll -u https://laptop1admin:laptop1adminpw@localhost:7054 --caname ca.laptop1 -M ${PWD}/../crypto-config/peerOrganizations/laptop1/users/Admin@laptop1/msp --tls.certfiles ${PWD}/fabric-ca/laptop1/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/laptop1/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/laptop1/users/Admin@laptop1/msp/config.yaml

}

createcertificatesForLaptop1
