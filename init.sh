#!/bin/bash

# slither
pip3 install slither-analyzer
pip3 install solc-select
solc-select install 0.8.18
solc-select use 0.8.18

#mythril
docker pull mythril/myth
