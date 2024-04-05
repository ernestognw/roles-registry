// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {BaseScript, Script} from "./Base.s.sol";
import {ICreateX} from "createx/ICreateX.sol";
import {Bytes32RolesRegistry} from "~/Bytes32RolesRegistry.sol";

contract Bytes32RolesRegistryDeployScript is BaseScript {
    address constant CREATE_X = 0xba5Ed099633D3B313e4D5F7bdc1305d3c28ba5Ed;
    ICreateX public createX;

    function setUp() public {
        createX = ICreateX(CREATE_X);
    }

    function run() public broadcast {
        createX.deployCreate2(type(Bytes32RolesRegistry).creationCode);
    }
}
