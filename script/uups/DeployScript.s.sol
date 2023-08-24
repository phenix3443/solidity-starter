// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import "forge-std/Script.sol"; // solhint-disable
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts/proxy/utils/UUPSUpgradeable.sol";

abstract contract DeployScript is Script {
    uint256 public privateKey;
    address public implementation;
    bytes public data;
    address public proxyAddress;

    error InvalidAddress(string reason);

    modifier deploy() {
        _;
        if (implementation == address(0)) {
            revert InvalidAddress("implementation address can not be zero");
        }
        proxyAddress = address(new ERC1967Proxy(implementation, data));
    }

    modifier upgrade() {
        if (proxyAddress == address(0)) {
            revert InvalidAddress("proxy address can not be zero");
        }
        _;
        if (implementation == address(0)) {
            revert InvalidAddress("implementation address can not be zero");
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
