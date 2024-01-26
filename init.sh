#!/bin/bash
# husky
husky install
# pnpm
brew install pnpm
# foundry
curl -L https://foundry.paradigm.xyz | bash && foundryup
# slither
pip3 install slither-analyzer &&
    pip3 install solc-select &&
    solc-select install 0.8.20 &&
    solc-select use 0.8.20
#mythril
docker pull mythril/myth
