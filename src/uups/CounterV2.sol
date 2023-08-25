// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import {CounterV1} from "./CounterV1.sol";

contract CounterV2 is CounterV1 {
    function upgradeVersion() public {
        version = "v2";
    }

    function set(uint256 num) public {
        number = num;
    }
}
