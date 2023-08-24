#!/bin/bash
# shellcheck disable=all
source .env && forge script script/uups/DeployCounterV2.s.sol --rpc-url ${RPC_URL} --broadcast -vvvv
