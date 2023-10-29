// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol"; // solhint-disable
import "@openzeppelin/contracts/utils/Strings.sol";

contract Hello {
    enum Status {
        Pending,
        Running,
        Success
    }

    Status public status;

    constructor() {
        status = Status.Running;
    }

    function get() public view returns (Status) {
        return status;
    }
}
