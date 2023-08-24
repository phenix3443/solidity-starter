// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import "forge-std/Script.sol"; // solhint-disable-line
// solhint-disable-next-line
import {ITransparentUpgradeableProxy, TransparentUpgradeableProxy} from "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";

abstract contract DeployScript is Script {
    uint256 public privateKey;
    address public implementation;
    bytes public data;
    address public proxyAddress;

    error InvalidAddress(string reason);

    modifier deploy(address deployer) {
        if (deployer == address(0)) {
            revert InvalidAddress("deployer address can not be zero");
        }
        _;
        if (implementation == address(0)) {
            revert InvalidAddress("implementation address can not be zero");
        }
        proxyAddress = address(
            new TransparentUpgradeableProxy(implementation, deployer, data)
        );
    }

    modifier upgrade() {
        if (proxyAddress == address(0)) {
            revert InvalidAddress("proxy address can not be zero");
        }
        _;
        ITransparentUpgradeableProxy proxy = ITransparentUpgradeableProxy(
            proxyAddress
        );
        if (implementation == address(0)) {
            revert InvalidAddress("implementation address can not be zero");
        }
        proxy.upgradeToAndCall(implementation, data);
    }

    function run() external {
        vm.startBroadcast(privateKey);
        _run();
        vm.stopBroadcast();
    }

    function _run() internal virtual;
}
