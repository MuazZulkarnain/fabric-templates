createCretificateForPi5() {
  echo
  echo "Enroll the CA admin"
  echo
  mkdir -p ../crypto-config/ordererOrganizations/pi5

  export FABRIC_CA_CLIENT_HOME=${PWD}/../crypto-config/ordererOrganizations/pi5

  fabric-ca-client enroll -u https://admin:adminpw@localhost:9054 --caname ca.pi5 --tls.certfiles ${PWD}/fabric-ca/pi5/tls-cert.pem

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-pi5.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-pi5.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-pi5.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-pi5.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/../crypto-config/ordererOrganizations/pi5/msp/config.yaml

  echo
  echo "Register orderer"
  echo

  fabric-ca-client register --caname ca.pi5 --id.name orderer --id.secret ordererpw --id.type orderer --tls.certfiles ${PWD}/fabric-ca/pi5/tls-cert.pem

  echo
  echo "Register orderer2"
  echo

  fabric-ca-client register --caname ca.pi5 --id.name orderer2 --id.secret ordererpw --id.type orderer --tls.certfiles ${PWD}/fabric-ca/pi5/tls-cert.pem

  echo
  echo "Register orderer3"
  echo

  fabric-ca-client register --caname ca.pi5 --id.name orderer3 --id.secret ordererpw --id.type orderer --tls.certfiles ${PWD}/fabric-ca/pi5/tls-cert.pem

  echo
  echo "Register the orderer admin"
  echo

  fabric-ca-client register --caname ca.pi5 --id.name ordererAdmin --id.secret ordererAdminpw --id.type admin --tls.certfiles ${PWD}/fabric-ca/pi5/tls-cert.pem

  mkdir -p ../crypto-config/ordererOrganizations/pi5/orderers
  # mkdir -p ../crypto-config/ordererOrganizations/pi5/orderers/pi5

  # ---------------------------------------------------------------------------
  #  Pi5

  mkdir -p ../crypto-config/ordererOrganizations/pi5/orderers/orderer.pi5

  echo
  echo "## Generate the orderer msp"
  echo

  fabric-ca-client enroll -u https://orderer:ordererpw@localhost:9054 --caname ca.pi5 -M ${PWD}/../crypto-config/ordererOrganizations/pi5/orderers/orderer.pi5/msp --csr.hosts orderer.pi5 --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/pi5/tls-cert.pem

  cp ${PWD}/../crypto-config/ordererOrganizations/pi5/msp/config.yaml ${PWD}/../crypto-config/ordererOrganizations/pi5/orderers/orderer.pi5/msp/config.yaml

  echo
  echo "## Generate the orderer-tls certificates"
  echo

  fabric-ca-client enroll -u https://orderer:ordererpw@localhost:9054 --caname ca.pi5 -M ${PWD}/../crypto-config/ordererOrganizations/pi5/orderers/orderer.pi5/tls --enrollment.profile tls --csr.hosts orderer.pi5 --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/pi5/tls-cert.pem

  cp ${PWD}/../crypto-config/ordererOrganizations/pi5/orderers/orderer.pi5/tls/tlscacerts/* ${PWD}/../crypto-config/ordererOrganizations/pi5/orderers/orderer.pi5/tls/ca.crt
  cp ${PWD}/../crypto-config/ordererOrganizations/pi5/orderers/orderer.pi5/tls/signcerts/* ${PWD}/../crypto-config/ordererOrganizations/pi5/orderers/orderer.pi5/tls/server.crt
  cp ${PWD}/../crypto-config/ordererOrganizations/pi5/orderers/orderer.pi5/tls/keystore/* ${PWD}/../crypto-config/ordererOrganizations/pi5/orderers/orderer.pi5/tls/server.key

  mkdir ${PWD}/../crypto-config/ordererOrganizations/pi5/orderers/orderer.pi5/msp/tlscacerts
  cp ${PWD}/../crypto-config/ordererOrganizations/pi5/orderers/orderer.pi5/tls/tlscacerts/* ${PWD}/../crypto-config/ordererOrganizations/pi5/orderers/orderer.pi5/msp/tlscacerts/tlsca.pi5-cert.pem

  mkdir ${PWD}/../crypto-config/ordererOrganizations/pi5/msp/tlscacerts
  cp ${PWD}/../crypto-config/ordererOrganizations/pi5/orderers/orderer.pi5/tls/tlscacerts/* ${PWD}/../crypto-config/ordererOrganizations/pi5/msp/tlscacerts/tlsca.pi5-cert.pem

  # -----------------------------------------------------------------------
  #  Pi5 2

  mkdir -p ../crypto-config/ordererOrganizations/pi5/orderers/orderer2.pi5

  echo
  echo "## Generate the orderer2 msp"
  echo

  fabric-ca-client enroll -u https://orderer2:ordererpw@localhost:9054 --caname ca.pi5 -M ${PWD}/../crypto-config/ordererOrganizations/pi5/orderers/orderer2.pi5/msp --csr.hosts orderer2.pi5 --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/pi5/tls-cert.pem

  cp ${PWD}/../crypto-config/ordererOrganizations/pi5/msp/config.yaml ${PWD}/../crypto-config/ordererOrganizations/pi5/orderers/orderer2.pi5/msp/config.yaml

  echo
  echo "## Generate the orderer2-tls certificates"
  echo

  fabric-ca-client enroll -u https://orderer2:ordererpw@localhost:9054 --caname ca.pi5 -M ${PWD}/../crypto-config/ordererOrganizations/pi5/orderers/orderer2.pi5/tls --enrollment.profile tls --csr.hosts orderer2.pi5 --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/pi5/tls-cert.pem

  cp ${PWD}/../crypto-config/ordererOrganizations/pi5/orderers/orderer2.pi5/tls/tlscacerts/* ${PWD}/../crypto-config/ordererOrganizations/pi5/orderers/orderer2.pi5/tls/ca.crt
  cp ${PWD}/../crypto-config/ordererOrganizations/pi5/orderers/orderer2.pi5/tls/signcerts/* ${PWD}/../crypto-config/ordererOrganizations/pi5/orderers/orderer2.pi5/tls/server.crt
  cp ${PWD}/../crypto-config/ordererOrganizations/pi5/orderers/orderer2.pi5/tls/keystore/* ${PWD}/../crypto-config/ordererOrganizations/pi5/orderers/orderer2.pi5/tls/server.key

  mkdir ${PWD}/../crypto-config/ordererOrganizations/pi5/orderers/orderer2.pi5/msp/tlscacerts
  cp ${PWD}/../crypto-config/ordererOrganizations/pi5/orderers/orderer2.pi5/tls/tlscacerts/* ${PWD}/../crypto-config/ordererOrganizations/pi5/orderers/orderer2.pi5/msp/tlscacerts/tlsca.pi5-cert.pem

  # ---------------------------------------------------------------------------
  #  Pi5 3
  mkdir -p ../crypto-config/ordererOrganizations/pi5/orderers/orderer3.pi5

  echo
  echo "## Generate the orderer3 msp"
  echo

  fabric-ca-client enroll -u https://orderer3:ordererpw@localhost:9054 --caname ca.pi5 -M ${PWD}/../crypto-config/ordererOrganizations/pi5/orderers/orderer3.pi5/msp --csr.hosts orderer3.pi5 --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/pi5/tls-cert.pem

  cp ${PWD}/../crypto-config/ordererOrganizations/pi5/msp/config.yaml ${PWD}/../crypto-config/ordererOrganizations/pi5/orderers/orderer3.pi5/msp/config.yaml

  echo
  echo "## Generate the orderer3-tls certificates"
  echo

  fabric-ca-client enroll -u https://orderer3:ordererpw@localhost:9054 --caname ca.pi5 -M ${PWD}/../crypto-config/ordererOrganizations/pi5/orderers/orderer3.pi5/tls --enrollment.profile tls --csr.hosts orderer3.pi5 --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/pi5/tls-cert.pem

  cp ${PWD}/../crypto-config/ordererOrganizations/pi5/orderers/orderer3.pi5/tls/tlscacerts/* ${PWD}/../crypto-config/ordererOrganizations/pi5/orderers/orderer3.pi5/tls/ca.crt
  cp ${PWD}/../crypto-config/ordererOrganizations/pi5/orderers/orderer3.pi5/tls/signcerts/* ${PWD}/../crypto-config/ordererOrganizations/pi5/orderers/orderer3.pi5/tls/server.crt
  cp ${PWD}/../crypto-config/ordererOrganizations/pi5/orderers/orderer3.pi5/tls/keystore/* ${PWD}/../crypto-config/ordererOrganizations/pi5/orderers/orderer3.pi5/tls/server.key

  mkdir ${PWD}/../crypto-config/ordererOrganizations/pi5/orderers/orderer3.pi5/msp/tlscacerts
  cp ${PWD}/../crypto-config/ordererOrganizations/pi5/orderers/orderer3.pi5/tls/tlscacerts/* ${PWD}/../crypto-config/ordererOrganizations/pi5/orderers/orderer3.pi5/msp/tlscacerts/tlsca.pi5-cert.pem
  # ---------------------------------------------------------------------------

  mkdir -p ../crypto-config/ordererOrganizations/pi5/users
  mkdir -p ../crypto-config/ordererOrganizations/pi5/users/Admin@pi5

  echo
  echo "## Generate the admin msp"
  echo

  fabric-ca-client enroll -u https://ordererAdmin:ordererAdminpw@localhost:9054 --caname ca.pi5 -M ${PWD}/../crypto-config/ordererOrganizations/pi5/users/Admin@pi5/msp --tls.certfiles ${PWD}/fabric-ca/pi5/tls-cert.pem

  cp ${PWD}/../crypto-config/ordererOrganizations/pi5/msp/config.yaml ${PWD}/../crypto-config/ordererOrganizations/pi5/users/Admin@pi5/msp/config.yaml

}

createCretificateForPi5