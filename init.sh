#!/bin/bash

# foundry
curl -L https://foundry.paradigm.xyz | bash && foundryup
# slither
pip3 install slither-analyzer &&
    pip3 install solc-select &&
    solc-select install 0.8.20 &&
    solc-select use 0.8.20
#mythril
docker pull mythril/myth
