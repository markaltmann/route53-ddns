#!/bin/bash

IP=`curl -q checkip.amazonaws.com`
HOSTNAME="gatekeeper.altmann.it"
ZONEID="HOSTEDZONEIDGOESHERE"

#######################

XML="<?xml version=\"1.0\" encoding=\"UTF-8\"?><ChangeResourceRecordSetsRequest xmlns=\"https://route53.amazonaws.com/doc/2013-04-01/\"><ChangeBatch><Changes><Change><Action>UPSERT</Action><ResourceRecordSet><Name>${HOSTNAME}.</Name><Type>A</Type><TTL>600</TTL><ResourceRecords><ResourceRecord><Value>${IP}</Value></ResourceRecord></ResourceRecords></ResourceRecordSet></Change></Changes></ChangeBatch></ChangeResourceRecordSetsRequest>"

perl dnscurl.pl --keyfile aws-secrets --keyname my-aws-account -- -X POST -d "${XML}" -H "Content-Type: text/xml; charset=UTF-8" https://route53.amazonaws.com/2013-04-01/hostedzone/${ZONEID}/rrset
