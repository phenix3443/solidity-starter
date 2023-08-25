// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import {TPCounterV1} from "./TPCounterV1.sol";

contract TPCounterV2 is TPCounterV1 {
    function upgradeVersion() public {
        version = "v2";
    }

    function set(uint256 num) public {
        number = num;
    }
}
