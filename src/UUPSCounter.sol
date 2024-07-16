// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

contract CounterV1 is OwnableUpgradeable, UUPSUpgradeable {
    string public version;
    uint256 public number;

    function initialize() public initializer {
        OwnableUpgradeable.__Ownable_init(msg.sender);
        version = "v1";
    }

    function incr() public {
        number++;
    }

    function _authorizeUpgrade(
        address newImplementation
    ) internal virtual override onlyOwner {} // solhint-disable-line
}

contract CounterV2 is CounterV1 {
    function upgradeVersion() public {
        version = "v2";
    }

    function set(uint256 num) public {
        number = num;
    }
}
