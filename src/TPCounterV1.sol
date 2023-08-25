// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

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
