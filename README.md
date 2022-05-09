# XDC Test Network

- XDC Private - Create your own Private Blockchain,
- Setup a XDC private network with four Masternodes,
- In this repository you will get a step-by-step guidance on setting up a hassle free XDC blockchain without knowing blockchain knowledge.

## Prerequisite -

**Hardware requirements** -

| Hardware     | Minimum   | Desired  |
| :----------- | :-------- | :------- |
| **Compute**: | t2 medium | t3 large |
| **Memory**:  | 8 GB      | 16 GB    |
| **Storage**: | 100 GB    | 500 GB   |

**Software requirements** -

|       Software       |                                                   Type                                                   |
| :------------------: | :------------------------------------------------------------------------------------------------------: |
| **Operating System** |                                      Ubuntu 20.04 64-bit or higher                                       |
|     **Language**     |                                              Golang , Shell                                              |
|      **Wallet**      | **[XDCPay](https://chrome.google.com/webstore/detail/xdcpay/bocpokimicclpaiekenaeelehdjllofo?hl=en-GB)** |

## Step 1: Installation -

- Install golang - **[Golang](https://go.dev/doc/install)**

```bash
  sudo wget https://go.dev/dl/go1.18.linux-amd64.tar.gz

  sudo rm -rf /usr/local/go && tar -C /usr/local -xzf go1.18.linux-amd64.tar.gz
```

## Step 2: Create Environment Variables for easier access -

- Go Paths -

```bash
export GOROOT=/usr/local/go

export GOPATH=/home/ubuntu/go

export PATH=$PATH:/usr/local/go/bin
```

- After step 3.Prepare Test Network Client Software you get XDC path -

```bash
alias XDC=/home/ubuntu/XDPoSChain/build/bin/XDC
```

- For bootnode -

```bash
alias bootnode=/home/ubuntu/XDPoSChain/build/bin/bootnode
```

## Step 3: Prepare Test Network Client Software -

Clone the project -

```bash
  git clone https://github.com/XinFinOrg/XDPoSChain
```

- Go to the project directory -

```bash
  cd XDPoSChain
```

```bash
  git checkout v1.4.4
```

```bash
  sudo su
```

```bash
  apt-get install build-essential

  apt-get update

  apt-get install make
```

- Set go paths for make all ( Step 2 ) -

```bash
  make all
```

## Step 4: Customize the Genesis file Using the Puppeth Tool -

- **Genesis File is the file that contains all the information about the blockchain network.**
- _Note: Use XDCPay wallet for creating accounts & Copy every mentioned account and their Private keys._

- Run the Puppeth command and answer questions about your private chain.

```bash
cd /home/ubuntu/XDPoSChain/build/bin/

./puppeth
```

- For Creating Genesis file follow this document - [Hackernoon.com](https://hackernoon.com/how-to-set-up-a-private-blockchain-network-with-xdc-network-codebase) **OR** [XDC Test Network](https://leewayhertz.atlassian.net/wiki/spaces/XIN/pages/3804758165/Launch+Test+Network)

## Step 5: Prepare Test Network Software -

Clone the Local DPoS Setup repository -

```bash
  git clone https://github.com/XDCFoundation/xdc-testnetwork-leo.git
```

- Go to the project directory

```bash
  cd xdc-testnetwork-leo
```

## Step 6: Setup Bootnode -

Export bootnode path -

```bash
  alias bootnode=/home/ubuntu/XDPoSChain/build/bin/bootnode
```

- Initialize bootnode key by entering the command -

```bash
  bootnode -genkey bootnode.key
```

- Then you will get bootnode.key like: feadc15144001acacc5aa420e874fa34c66ba39851f48cf1746f94339ae49f7d

- Then start bootnode with the command -

```bash
  bootnode -nodekey ./bootnode.key
```

- Copy bootnode information shown like -

```bash
  enode://048fb0712b244999f62b8c4481f7ed4b2a47632a9b56e4947396b24a8cfa4af9e5490cb36294df76421269d83668f4ac51166bdf85b03b8e912ec07c0e8ef3a6@[::]:30301
```

- _Note - Make sure to add Public ip in enode-id (For connecting two different location nodes you should have to go with aws public ip)_
- Example -

```bash
  self=enode://048fb0712b244999f62b8c4481f7ed4b2a47632a9b56e4947396b24a8cfa4af9e5490cb36294df76421269d83668f4ac51166bdf85b03b8e912ec07c0e8ef3a6@13.96.100.33:30301
```

## Step 7: Start the Masternode -

Follow the following steps to start the masternode -

- Replace the genesis file in xdc-testnetwork-leo/genesis folder with yours genesis file which you created earlier.
- Edit node1.sh, node2.sh, node3.sh, node4.sh files by changing the and replacing the Bootnode enode-id which was generated earlier.
- Enter the private key of the 4 masternode in the .env file, ( masternode, and signers private keys ) which was mentioned in the genesis file.
- Give permission to all files

```bash
  chmod 777 <filename>
```

- Start your masternode with the commands, (Open new terminal for every node and set paths) -

```bash
  bash node1.sh

  Respectively same for more nodes...
```

## Step 8: Check Your Private Chain -

- Connect ipc -

`cd home/ubuntu/xdc-testnetwork-leo/nodes/1`

`XDC attach XDC.ipc`

- Output should look like this -

```bash
Welcome to the XDC JavaScript console!

instance: XDC/v1.4.4-stable-7808840b/linux-amd64/go1.17.7
coinbase: xdcb96016369693812449d6f08e64275d5d639258d1
at block: 10 (Mon, 28 Mar 2022 19:12:11 IST)
 datadir: /home/ubuntu/xdc-testnetwork-leo/nodes/1
 modules: XDCx:1.0 XDCxlending:1.0 XDPoS:1.0 admin:1.0 debug:1.0 eth:1.0 miner:1.0 net:1.0 personal:1.0 rpc:1.0 txpool:1.0 web3:1.0
 >

```

**This is the XDC JavaScript console.**

_Commands -_

- `eth.accounts` / `personal.listWallets` / `personal` - Accounts list .

- `eth.coinbase` - Check Default Account .

- `eth.blockNumber` - For check the block number.

- `eth.getBalance("<Account Number>")` - For check the balance of any account.

- `admin.peers` / `net.peerCount` -For Verifying your nodes are now communicating or not.

- `eth.sendTransaction({from: "<account1_address>", to: "<account2_address>", value: "10"})` - For doing the transaction on console.

- `eth.getTransactionReceipt("<Transaction hash>")` - For transaction details.

- `txpool` / `eth.pendingTransaction` - Check transaction pool if transaction facing any issues.

- `eth.getTransactionCount("<account public key>")` - For check transaction count.

- `admin.nodeInfo.enode` It gives you the enode id.

## Step 9: Troubleshooting (To stop the nodes or if you encounter any issues use) -

- Run -

```bash
bash reset.sh
```

- kill the processes used by XDC -

```bash
lsof -i

 kill <PID>
```

## **INTEGRATING XDC PRIVATE NETWORK WITH OTHER XDC APPLICATIONS -**

## 1. Connect XDC Test Network with XDCpay -

- Add Network -
- Network Name `XDC Testnetwork`
- RPC- `http://<Public ip of AWS/Local>:8545`
- Chain ID - `72`
- Currency Symbol (Optional) - `XDC`
- Save

## 2. Connect XDC Test Network with XDC Network Stats -

- Format - `--ethstats value` Reporting URL of a ethstats service (nodename:secret@host:port)
- For XDC Network States - `--ethstats "Node-01:xinfin_xdpos_hybrid_network_stats@stats.xinfin.network:3000"`

## 3. Connect XDC Test Network with Testnet faucet -

**Backend -**

- Clone repository - `git clone https://github.com/XDCFoundation/xdc-faucet-leo-backend.git`
- Update config.json ./config.json (see config.json with placeholders below)
- npm install from project's root - `npm i`
- Start the localhost server - `npm run dev`
- Server config.json (./config.json) with placeholders

```bash
"Ethereum": {
    "etherToTransfer": "type amount of Ether to be sent from faucet here, for example 0.5",
    "gasLimit": "type XDC transaction gas limit here, for example, 0x7b0c",
    "live": {
      "rpc": "type XDC RPC address here, for example http://127.0.0.1:8545",
      "account": "type sender address here, for example, 0xf36045454F66C7318adCDdF3B801E3bF8CfBc6a1",
      "privateKey": "type private key of sender here, for example, 54dd4125ed5418a7a68341413f4006256159f9f5ade8fed94e82785ef59523ab"
    },
    "dev": {
      ...
    }
}
```

**Frontend -**

- Clone repository - `git clone https://github.com/XDCFoundation/xdc-faucet-leo.git`
- Install Node Modules - `npm i`
- Start the localhost server - `npm start`

- Ex - [XDC Faucet](https://faucet.euphrates.network/)

## Reference -

- For more reference - [Hackernoon.com](https://hackernoon.com/how-to-set-up-a-private-blockchain-network-with-xdc-network-codebase)
