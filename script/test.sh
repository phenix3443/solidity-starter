#!/bin/bash
# shellcheck disable=all
source .env && cast call --rpc-url ${RPC_URL} 0x5fbdb2315678afecb367f032d93f642f64180aa3 'hello(string calldata message) public view returns (string memory)' 'hello,'
