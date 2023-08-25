#!/bin/bash
source .env && forge script script/transparent/DeployTPCounterV2.s.sol --rpc-url ${RPC_URL} --broadcast -vvvv
