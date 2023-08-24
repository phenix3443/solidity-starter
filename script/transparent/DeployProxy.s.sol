// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "forge-std/Script.sol"; // solhint-disable-line
// solhint-disable-next-line
import {ITransparentUpgradeableProxy, TransparentUpgradeableProxy} from "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import {CounterV2} from "../../src/transparent/CounterV2.sol";

contract DeployProxy is Script {
    address public implementation;
    bytes public data;
    modifier deploy(uint256 privateKey, address owner) {
        vm.startBroadcast(privateKey);
        _;
        new TransparentUpgradeableProxy(implementation, owner, data);
        vm.stopBroadcast();
    }

    modifier upgrade(uint256 privateKey, address proxyAddress) {
        vm.startBroadcast(privateKey);
        _;
        require(proxyAddress != address(0), "must have proxy address");
        ITransparentUpgradeableProxy proxy = ITransparentUpgradeableProxy(
            proxyAddress
        );
        proxy.upgradeToAndCall(implementation, data);
        vm.stopBroadcast();
    }
}
