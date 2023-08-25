#!/bin/bash
# shellcheck disable=all
source .env && forge script script/uups/DeployUUPSCounterV2.s.sol --rpc-url ${RPC_URL} --broadcast -vvvv
