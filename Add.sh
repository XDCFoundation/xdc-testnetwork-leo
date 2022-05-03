#!/bin/bash

touch .pwd
export $(cat .env | xargs)
Bin_NAME=XDC

WORK_DIR=$PWD
PROJECT_DIR="/home/ubuntu/XDPoSChain"
cd $PROJECT_DIR && make XDC
cd $WORK_DIR

if [ ! -d ./nodes/5/$Bin_NAME/chaindata ]
then
  wallet5=$(${PROJECT_DIR}/build/bin/$Bin_NAME account import --password .pwd --datadir ./nodes/5 <(echo ${PRIVATE_KEY_5}) | awk -v FS="({|})" '{print $2}')

  ${PROJECT_DIR}/build/bin/$Bin_NAME --datadir ./nodes/5 init ./genesis/genesis.json
else
  wallet5=$(${PROJECT_DIR}/build/bin/$Bin_NAME account list --datadir ./nodes/5 | head -n 1 | awk -v FS="({|})" '{print $2}')
fi

networkid=72

echo Starting the nodes ...

${PROJECT_DIR}/build/bin/$Bin_NAME --bootnodes "enode://47af697380c1eb76bdc04f5b1f1f6aff24da552f52f769055e8a51e573d38bba96d1144a7d51a00db76666fe502b148aa1d1c7344d3a9a4776fc0d88f2b5cd2c@54.163.43.173:30301" --syncmode "full" --datadir ./nodes/5 --networkid "${networkid}" --port 30307 --rpc --rpccorsdomain "*" --rpcaddr 0.0.0.0 --ws --wsaddr="0.0.0.0" --wsorigins "*" --wsport 8559 --rpcport 8549 --rpcvhosts "*" --unlock "${wallet5}" --password ./.pwd --mine --gasprice "1" --targetgaslimit "420000000" --verbosity 3 --rpcapi admin,db,eth,debug,miner,net,shh,txpool,personal,web3,XDPoS --ethstats "Leo-Node-05:xinfin_xdpos_hybrid_network_stats@stats.xinfin.network:3000" 2>XDC_node5.log &
