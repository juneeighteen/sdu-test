cd /home/qatest/sdu-test-tempest

OSAUTHURL="$(cat etc/tempest.conf | grep "uri= " | sed 's/uri= //')"
OSPASSWORD="$(cat etc/tempest.conf | grep "^password=" -m 1 | sed 's/password=//')"
OSTENANT="$(cat etc/tempest.conf | grep "^tenant_name" -m 1 | sed 's/tenant_name=//')"
OSUSER="$(cat etc/tempest.conf | grep "username=" -m 1 | sed 's/username=//')"
# echo $OSUSER
# echo $OSTENANT
# echo $OSAUTHURL
# echo $OSPASSWORD



nova --os-username $OSUSER --os-tenant-name $OSTENANT --os-password $OSPASSWORD --os-auth-url $OSAUTHURL flavor-list
# nova --os-username $OSUSER --os-tenant-name $OSTENANT --os-password $OSPASSWORD --os-auth-url $OSAUTHURL flavor-list | grep "GP-Large\|GP-Medium\|GP-Small" | cut -b 3-38 > flavors.txt
cat etc/tempest.conf | grep "^flavor_ref"


#CIRROS IMAGE_ID
CIRRUS_IMAGE_ID="$(nova --os-username $OSUSER --os-tenant-name $OSTENANT --os-password $OSPASSWORD --os-auth-url $OSAUTHURL image-list | grep "cirros" -m 1| cut -b 3-38)"
UBUNTU_IMAGE_ID="$(nova --os-username $OSUSER --os-tenant-name $OSTENANT --os-password $OSPASSWORD --os-auth-url $OSAUTHURL image-list | grep "ubunt" -m 1| cut -b 3-38)"
# echo "Cirrus image id is"
# echo $CIRRUS_IMAGE_ID
# echo "Ubuntu image id is"
# echo $UBUNTU_IMAGE_ID

nova --os-username $OSUSER --os-tenant-name $OSTENANT --os-password $OSPASSWORD --os-auth-url $OSAUTHURL image-list
cat etc/tempest.conf | grep "^image_ref"

nova --os-username $OSUSER --os-tenant-name $OSTENANT --os-password $OSPASSWORD --os-auth-url $OSAUTHURL network-list
cat etc/tempest.conf | grep "^fixed_network_name\|^public_network_id"
