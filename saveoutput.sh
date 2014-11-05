cd /home/qatest/sdu-test-tempest
rm -rf output
rm -rf output.tgz
RESULTS=$(basename $(ls -dt /home/qatest/sdu-test-tempest/etc/test_results* | head -1))
mkdir output
tools.cisco/get_results.sh > /home/qatest/sdu-test-tempest/output/output.txt
cp /home/qatest/sdu-test-tempest/etc/$RESULTS/* /home/qatest/sdu-test-tempest/output
cp /home/qatest/sdu-test-tempest/etc/tempest.conf /home/qatest/sdu-test-tempest/output/tempest.conf
cat /home/qatest/sdu-test-tempest/etc/tempest.conf | grep "uri=" > /home/qatest/sdu-test-tempest/output/WhatEnvironment.txt
tar cvzf output.tgz output/*
python sendresults.py
