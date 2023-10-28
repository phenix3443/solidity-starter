#!/bin/bash
# shellcheck disable=all
# source .env && forge script --target-contract DeployCounterV1 --rpc-url ${RPC_URL} --broadcast -vvvv script/DeployTP.s.sol
# source .env && forge script --target-contract DeployCounterV2 --rpc-url ${RPC_URL} --broadcast -vvvv script/DeployTP.s.sol
# source .env && forge script --target-contract DeployCounterV1 --rpc-url ${RPC_URL} --broadcast -vvvv script/DeployUUPS.s.sol
# source .env && forge script --target-contract DeployCounterV2 --rpc-url ${RPC_URL} --broadcast -vvvv script/DeployUUPS.s.sol
source .env && forge script --target-contract DeployHello --rpc-url ${RPC_URL} --broadcast -vvvv script/DeployHello.s.sol
