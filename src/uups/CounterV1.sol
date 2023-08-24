// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts/proxy/utils/UUPSUpgradeable.sol";

contract CounterV1 is OwnableUpgradeable, UUPSUpgradeable {
    string public version;
    uint256 public number;

    function initialize() public initializer {
        OwnableUpgradeable.__Ownable_init();
        version = "v1";
    }

    function incr() public {
        number++;
    }

    function _authorizeUpgrade(
        address newImplementation
    ) internal virtual override onlyOwner {} // solhint-disable-line
}
