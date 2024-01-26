// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract TPCounterV1 is Initializable {
    string public version;
    uint256 public number;

    function initialize() public initializer {
        version = "v1";
    }

    function incr() public {
        number++;
    }
}

contract TPCounterV2 is TPCounterV1 {
    function upgradeVersion() public {
        version = "v2";
    }

    function set(uint256 num) public {
        number = num;
    }
}
