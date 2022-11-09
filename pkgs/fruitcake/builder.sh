source $stdenv/setup

sshpass -p simpet_dummy                                                                \
        sftp -P 49166                                                                  \
             -o StrictHostKeyChecking=no                                               \
             -o UserKnownHostsFile=/dev/null                                           \
             simpet_install@mibiolab.synology.me:SIMPET/simpet_resources/fruitcake.zip

mkdir -p $out/bin
mkdir -p $out/lib
unzip fruitcake.zip
install -D        fruitcake/bin/*      $out/bin
install -D -m=666 fruitcake/book/lib/* $out/lib
