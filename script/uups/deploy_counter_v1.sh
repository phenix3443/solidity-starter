#!/bin/bash
source .env && forge script script/uups/DeployCounterV1.s.sol --rpc-url ${RPC_URL} --broadcast -vvvv
