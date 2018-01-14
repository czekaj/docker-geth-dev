FROM ethereum/client-go

# # our own custom bult geth that mines really fast
# COPY geth /usr/bin/geth

RUN apk add --update bash

# script that invokes with all those
# command line options
COPY rungeth.docker /usr/bin/rungeth

# these two files and directory of geth state belong together and must be
# kept in sync if changes  are ever made
# Note we are taking advantage of Docker's copy-on-mount feature
COPY geth.password /root/geth.password
COPY genesis.json  /root/genesis.json
COPY ethereum /root/.ethereum

ENTRYPOINT ["/usr/bin/rungeth"]

