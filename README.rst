===============
Docker-geth-dev
===============

This runs a container with private Ethereum chain with some precreated accounts
and balances. This is inspired by the `StackOverflow thread <http://ethereum.stackexchange.com/questions/1516/how-can-i-completely-automate-a-docker-image-and-dockerfile-for-a-geth-test-netw>`_ and fixing problems encountered on the way.

This fork updates the https://github.com/pragmaticcoders/docker-geth-dev version to make it run again with geth 1.8.0 and the alpine linux image.

1. Build the container: ::

     ethereum/client-go:privnet .


2. Run as standalone command for RPC use: ::

     docker run -it --name geth -d ethereum/client-go:privnet



3. Run as part of docker-compose: ::

     geth:
       image: ethereum/client-go:privnet
       ports:
         - "8545:8545"


Precreated accounts
===================

- ``0x94d513eb350b90f79ae5e6b33e3e0ea0d4835031`` (initial balance: 3000 wei).
  This account is used as a coinbase for mining, so it will have plenty of ether
  fast.

- ``0x24bc3b86f28019a521c652648177e27b4f3e0d7a`` (initial balance: 2000 wei)

- ``0x0949b4a649d2bb2da8d5af755190e1e91cfaf8ec`` (initial balance: 1000 wei)

All the accounts have the same passphrase: ``ComplexPassword123#``


Example: check balance with RPC call
====================================

You can run ::

  curl -X POST --data '{"jsonrpc":"2.0","method":"eth_getBalance","params":["0x24bc3b86f28019a521c652648177e27b4f3e0d7a", "latest"],"id":1}' -H "Content-Type: application/json" localhost:8545

The response should be: ::

  {"jsonrpc":"2.0","id":1,"result":"0x7d0"}

(``0x7d0`` is hex for ``2000``)

Running Mist on our privnet
===========================

Modify your Mist desktop shortcut (Windows) ::

  "C:\Program Files\Mist\Mist.exe" --node-datadir="%HOMEPATH%\AppData\Roaming\Ethereum\privatenet" --rpc http://127.0.0.1:8545  --node-networkid 1234 --swarmurl="http://swarm-gateways.net"

