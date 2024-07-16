#!/bin/bash
# shellcheck disable=all
source .env
# forge script --target-contract DeployCounterV1 --rpc-url ${RPC_URL} --broadcast -vvvv script/DeployTP.s.sol
# forge script --target-contract DeployCounterV2 --rpc-url ${RPC_URL} --broadcast -vvvv script/DeployTP.s.sol
# forge script --target-contract DeployCounterV1 --rpc-url ${RPC_URL} --broadcast -vvvv script/DeployUUPS.s.sol
# forge script --target-contract DeployCounterV2 --rpc-url ${RPC_URL} --broadcast -vvvv script/DeployUUPS.s.sol
# forge script --target-contract DeployHello --rpc-url ${RPC_URL} --broadcast -vvvv script/DeployHello.s.sol
# forge script --target-contract Step1 --rpc-url ${RPC_URL} --broadcast -vvvv script/DeployCreate.s.sol
# forge script --target-contract Step2 --rpc-url ${RPC_URL} --broadcast -vvvv script/DeployCreate.s.sol
forge script --fork-url ${RPC_URL} --broadcast -vvvv script/Counter.s.sol

forge script --broadcast -vvvv script/Counter.s.sol --verify --chain holesky --rpc-url https://holesky.infura.io/v3/8df7a81470744671a93b447dc0322003 --private-key 9d216fbe6b621ad7441223249192c0c9812e7d0801be30b0844818d252c3f70b --sender 0xbCb2a0C8b853F46e4a26348E87D535F26E6B0C17
