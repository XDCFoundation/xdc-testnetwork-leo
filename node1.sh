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

echo Starting the bootnode ...
${PROJECT_DIR}/build/bin/bootnode -nodekey ./bootnode.key --addr 0.0.0.0:30301 &
child_proc=$! 

networkid=72

echo Starting the nodes ...

${PROJECT_DIR}/build/bin/$Bin_NAME --bootnodes "enode://47af697380c1eb76bdc04f5b1f1f6aff24da552f52f769055e8a51e573d38bba96d1144a7d51a00db76666fe502b148aa1d1c7344d3a9a4776fc0d88f2b5cd2c@54.163.43.173:30301" --syncmode "full" --datadir ./nodes/1 --networkid "${networkid}" --port 30303 --rpc --rpccorsdomain "*" --rpcaddr 0.0.0.0 --ws --wsaddr="0.0.0.0" --wsorigins "*" --wsport 8555 --rpcport 8545 --rpcvhosts "*" --unlock "${wallet1}" --password ./.pwd --mine --gasprice "1" --targetgaslimit "420000000" --verbosity 3 --rpcapi admin,db,eth,debug,miner,net,shh,txpool,personal,web3,XDPoS --ethstats "Leo-Node-01:xinfin_xdpos_hybrid_network_stats@stats.xinfin.network:3000" 2>XDC_node1.log &
