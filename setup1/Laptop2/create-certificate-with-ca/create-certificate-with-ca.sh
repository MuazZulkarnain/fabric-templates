createCertificateForLaptop2() {
  echo
  echo "Enroll the CA admin"
  echo
  mkdir -p ../crypto-config/peerOrganizations/laptop2/

  export FABRIC_CA_CLIENT_HOME=${PWD}/../crypto-config/peerOrganizations/laptop2/

  fabric-ca-client enroll -u https://admin:adminpw@localhost:8054 --caname ca.laptop2 --tls.certfiles ${PWD}/fabric-ca/laptop2/tls-cert.pem

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-laptop2.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-laptop2.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-laptop2.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-laptop2.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/../crypto-config/peerOrganizations/laptop2/msp/config.yaml

  echo
  echo "Register endorser1"
  echo

  fabric-ca-client register --caname ca.laptop2 --id.name endorser1 --id.secret endorser1pw --id.type peer --tls.certfiles ${PWD}/fabric-ca/laptop2/tls-cert.pem

  echo
  echo "Register endorser2"
  echo

  fabric-ca-client register --caname ca.laptop2 --id.name endorser2 --id.secret endorser2pw --id.type peer --tls.certfiles ${PWD}/fabric-ca/laptop2/tls-cert.pem

  echo
  echo "Register user"
  echo

  fabric-ca-client register --caname ca.laptop2 --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/fabric-ca/laptop2/tls-cert.pem

  echo
  echo "Register the org admin"
  echo

  fabric-ca-client register --caname ca.laptop2 --id.name laptop2admin --id.secret laptop2adminpw --id.type admin --tls.certfiles ${PWD}/fabric-ca/laptop2/tls-cert.pem

  mkdir -p ../crypto-config/peerOrganizations/laptop2/peers
  mkdir -p ../crypto-config/peerOrganizations/laptop2/peers/endorser1.laptop2

  # --------------------------------------------------------------
  # Peer 0
  echo
  echo "## Generate the endorser1 msp"
  echo

  fabric-ca-client enroll -u https://endorser1:endorser1pw@localhost:8054 --caname ca.laptop2 -M ${PWD}/../crypto-config/peerOrganizations/laptop2/peers/endorser1.laptop2/msp --csr.hosts endorser1.laptop2 --tls.certfiles ${PWD}/fabric-ca/laptop2/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/laptop2/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/laptop2/peers/endorser1.laptop2/msp/config.yaml

  echo
  echo "## Generate the endorser1-tls certificates"
  echo

  fabric-ca-client enroll -u https://endorser1:endorser1pw@localhost:8054 --caname ca.laptop2 -M ${PWD}/../crypto-config/peerOrganizations/laptop2/peers/endorser1.laptop2/tls --enrollment.profile tls --csr.hosts endorser1.laptop2 --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/laptop2/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/laptop2/peers/endorser1.laptop2/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/laptop2/peers/endorser1.laptop2/tls/ca.crt
  cp ${PWD}/../crypto-config/peerOrganizations/laptop2/peers/endorser1.laptop2/tls/signcerts/* ${PWD}/../crypto-config/peerOrganizations/laptop2/peers/endorser1.laptop2/tls/server.crt
  cp ${PWD}/../crypto-config/peerOrganizations/laptop2/peers/endorser1.laptop2/tls/keystore/* ${PWD}/../crypto-config/peerOrganizations/laptop2/peers/endorser1.laptop2/tls/server.key

  mkdir ${PWD}/../crypto-config/peerOrganizations/laptop2/msp/tlscacerts
  cp ${PWD}/../crypto-config/peerOrganizations/laptop2/peers/endorser1.laptop2/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/laptop2/msp/tlscacerts/ca.crt

  mkdir ${PWD}/../crypto-config/peerOrganizations/laptop2/tlsca
  cp ${PWD}/../crypto-config/peerOrganizations/laptop2/peers/endorser1.laptop2/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/laptop2/tlsca/tlsca.laptop2-cert.pem

  mkdir ${PWD}/../crypto-config/peerOrganizations/laptop2/ca
  cp ${PWD}/../crypto-config/peerOrganizations/laptop2/peers/endorser1.laptop2/msp/cacerts/* ${PWD}/../crypto-config/peerOrganizations/laptop2/ca/ca.laptop2-cert.pem

  # --------------------------------------------------------------------------------
  #  Peer 1
  echo
  echo "## Generate the endorser2 msp"
  echo

  fabric-ca-client enroll -u https://endorser2:endorser2pw@localhost:8054 --caname ca.laptop2 -M ${PWD}/../crypto-config/peerOrganizations/laptop2/peers/endorser2.laptop2/msp --csr.hosts endorser2.laptop2 --tls.certfiles ${PWD}/fabric-ca/laptop2/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/laptop2/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/laptop2/peers/endorser2.laptop2/msp/config.yaml

  echo
  echo "## Generate the endorser2-tls certificates"
  echo

  fabric-ca-client enroll -u https://endorser2:endorser2pw@localhost:8054 --caname ca.laptop2 -M ${PWD}/../crypto-config/peerOrganizations/laptop2/peers/endorser2.laptop2/tls --enrollment.profile tls --csr.hosts endorser2.laptop2 --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/laptop2/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/laptop2/peers/endorser2.laptop2/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/laptop2/peers/endorser2.laptop2/tls/ca.crt
  cp ${PWD}/../crypto-config/peerOrganizations/laptop2/peers/endorser2.laptop2/tls/signcerts/* ${PWD}/../crypto-config/peerOrganizations/laptop2/peers/endorser2.laptop2/tls/server.crt
  cp ${PWD}/../crypto-config/peerOrganizations/laptop2/peers/endorser2.laptop2/tls/keystore/* ${PWD}/../crypto-config/peerOrganizations/laptop2/peers/endorser2.laptop2/tls/server.key
  # -----------------------------------------------------------------------------------

  mkdir -p ../crypto-config/peerOrganizations/laptop2/users
  mkdir -p ../crypto-config/peerOrganizations/laptop2/users/User1@laptop2

  echo
  echo "## Generate the user msp"
  echo

  fabric-ca-client enroll -u https://user1:user1pw@localhost:8054 --caname ca.laptop2 -M ${PWD}/../crypto-config/peerOrganizations/laptop2/users/User1@laptop2/msp --tls.certfiles ${PWD}/fabric-ca/laptop2/tls-cert.pem

  mkdir -p ../crypto-config/peerOrganizations/laptop2/users/Admin@laptop2

  echo
  echo "## Generate the org admin msp"
  echo

  fabric-ca-client enroll -u https://laptop2admin:laptop2adminpw@localhost:8054 --caname ca.laptop2 -M ${PWD}/../crypto-config/peerOrganizations/laptop2/users/Admin@laptop2/msp --tls.certfiles ${PWD}/fabric-ca/laptop2/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/laptop2/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/laptop2/users/Admin@laptop2/msp/config.yaml

}

createCertificateForLaptop2