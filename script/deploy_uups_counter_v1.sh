#!/bin/bash
source .env && forge script script/uups/DeployUUPSCounterV1.s.sol --rpc-url ${RPC_URL} --broadcast -vvvv
