#!/bin/bash
source .env && forge script script/transparent/DeployTPCounterV1.s.sol --rpc-url ${RPC_URL} --broadcast -vvvv
