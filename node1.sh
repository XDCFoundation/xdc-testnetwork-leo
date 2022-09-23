#!/bin/bash

touch .pwd
export $(cat .env | xargs)
Bin_NAME=XDC

WORK_DIR=$PWD
PROJECT_DIR="/home/ubuntu/XDPoSChain"
cd $PROJECT_DIR && make XDC
cd $WORK_DIR

if [ ! -d ./nodes/1/$Bin_NAME/chaindata ]
then
  wallet1=$(${PROJECT_DIR}/build/bin/$Bin_NAME account import --password .pwd --datadir ./nodes/1 <(echo ${PRIVATE_KEY_1}) | awk -v FS="({|})" '{print $2}')

  ${PROJECT_DIR}/build/bin/$Bin_NAME --datadir ./nodes/1 init ./genesis/genesis.json
 else
  wallet1=$(${PROJECT_DIR}/build/bin/$Bin_NAME account list --datadir ./nodes/1 | head -n 1 | awk -v FS="({|})" '{print $2}')

fi

networkid=72

echo Starting the nodes ...

${PROJECT_DIR}/build/bin/$Bin_NAME --bootnodes "enode://8eb9511690a3a51aac4bd25f739d96c007238691f3f5d0d5ba51fc50d52208153467048dfd2aad0fdc065cde027b2fdd4b233e03c7f70c3921441c00f515b514@44.204.238.41:30301,enode://8eb9511690a3a51aac4bd25f739d96c007238691f3f5d0d5ba51fc50d52208153467048dfd2aad0fdc065cde027b2fdd4b233e03c7f70c3921441c00f515b514@54.82.14.217:30301,enode://8eb9511690a3a51aac4bd25f739d96c007238691f3f5d0d5ba51fc50d52208153467048dfd2aad0fdc065cde027b2fdd4b233e03c7f70c3921441c00f515b514@34.238.40.201:30301,enode://8eb9511690a3a51aac4bd25f739d96c007238691f3f5d0d5ba51fc50d52208153467048dfd2aad0fdc065cde027b2fdd4b233e03c7f70c3921441c00f515b514@35.171.25.71:30301" --syncmode "full" --datadir ./nodes/1 --networkid "${networkid}" --port 30303 --rpc --rpccorsdomain "*" --rpcaddr 0.0.0.0 --ws --wsaddr="0.0.0.0" --wsorigins "*" --wsport 8555 --rpcport 8545 --rpcvhosts "*" --unlock "${wallet1}" --password ./.pwd --mine --gasprice "1" --targetgaslimit "420000000" --verbosity 3 --rpcapi admin,db,eth,debug,miner,net,shh,txpool,personal,web3,XDPoS --ethstats "Leo-Node-01:xinfin_xdpos_hybrid_network_stats@stats.xinfin.network:3000" 2>XDC_node1.log &
