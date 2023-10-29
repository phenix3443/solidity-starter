#!/bin/bash
# shellcheck disable=all
source .env && cast send --rpc-url ${RPC_URL} --private-key ${PRIVATE_KEY} 0x5fbdb2315678afecb367f032d93f642f64180aa3 'set(string calldata name, uint256 _balance)' john 256
# get People struct
source .env && cast call --rpc-url ${RPC_URL} 0x5fbdb2315678afecb367f032d93f642f64180aa3 'get() returns ((string,uint256)[])'
# get status enum
source .env && cast call --rpc-url ${RPC_URL} 0x5fbdb2315678afecb367f032d93f642f64180aa3 'get() returns (uint8)'
# test receive
source .env && cast send --rpc-url ${RPC_URL} --private-key ${PRIVATE_KEY} 0x5fbdb2315678afecb367f032d93f642f64180aa3 --value 1ether
# test create contract
source .env && cast call --rpc-url ${RPC_URL} 0x5fbdb2315678afecb367f032d93f642f64180aa3 'showCars()'
