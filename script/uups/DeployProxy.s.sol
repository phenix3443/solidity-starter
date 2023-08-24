// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "forge-std/Script.sol"; // solhint-disable
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts/proxy/utils/UUPSUpgradeable.sol";

abstract contract DeployProxy is Script {
    uint256 public privateKey;
    address implementation;
    bytes data;

    error InvalidProxyAddress(string reason);
    error InvalidImplAddress(string reason);

    modifier deploy() {
        _;
        if (implementation == address(0)) {
            revert InvalidImplAddress("must not zero");
        }
        new ERC1967Proxy(implementation, data);
    }

    modifier upgrade(address proxyAddress) {
        if (proxyAddress == address(0)) {
            revert InvalidProxyAddress("must not zero");
        }
        _;
        if (implementation == address(0)) {
            revert InvalidImplAddress("must not zero");
        }
        UUPSUpgradeable proxy = UUPSUpgradeable(proxyAddress);
        proxy.upgradeToAndCall(address(implementation), data);
    }

    function run() external {
        vm.startBroadcast(privateKey);
        _run();
        vm.stopBroadcast();
    }

    function _run() internal virtual;
}
