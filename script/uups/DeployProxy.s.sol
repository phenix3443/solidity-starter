// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "forge-std/Script.sol"; // solhint-disable
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts/proxy/utils/UUPSUpgradeable.sol";

contract DeployProxy is Script {
    address implementation;
    bytes data;

    modifier deploy(uint256 privateKey) {
        vm.startBroadcast(privateKey);
        _;
        require(implementation != address(0), "must have implementation");
        new ERC1967Proxy(implementation, data);
        vm.stopBroadcast();
    }

    modifier upgrade(uint256 privateKey, address proxyAddress) {
        require(proxyAddress != address(0), "must have proxy address");
        vm.startBroadcast(privateKey);
        _;
        require(implementation != address(0), "must have implementation");
        UUPSUpgradeable proxy = UUPSUpgradeable(proxyAddress);
        proxy.upgradeToAndCall(address(implementation), data);
        vm.stopBroadcast();
    }
}
