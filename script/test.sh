#!/bin/bash
# shellcheck disable=all
source .env && cast send --rpc-url ${RPC_URL} --private-key ${PRIVATE_KEY} 0x5fbdb2315678afecb367f032d93f642f64180aa3 'set(string calldata name, uint256 _balance)' john 256
source .env && cast call --rpc-url ${RPC_URL} 0x5fbdb2315678afecb367f032d93f642f64180aa3 'get() returns (string[] memory)'
source .env && cast call --rpc-url ${RPC_URL} 0x5fbdb2315678afecb367f032d93f642f64180aa3 'peoples(uint256) returns (string)' 0
