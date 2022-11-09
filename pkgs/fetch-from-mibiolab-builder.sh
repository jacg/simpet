source $stdenv/setup

sshpass -p simpet_dummy                                                                \
        sftp -P 49166                                                                  \
             -o StrictHostKeyChecking=no                                               \
             -o UserKnownHostsFile=/dev/null                                           \
             simpet_install@mibiolab.synology.me:SIMPET/simpet_resources/$artefact

unzip $artefact


sh <(printenv installFetched)
