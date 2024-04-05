// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Bytes32RolesRegistry} from "../src/Bytes32RolesRegistry.sol";

contract Bytes32RolesRegistryTest is Test {
    // Hashed bytes32 string literals (<= 32 bytes)
    bytes32 constant BYTES32_STRING_LITERAL = "FOO";
    bytes32 constant STANDARD_BYTES32_STRING_LITERAL_ROLE =
        keccak256(abi.encodePacked(BYTES32_STRING_LITERAL));

    // Hashed strings (> 32 bytes)
    string constant STRING_LITERAL =
        "this is a long string that doesn't fit in 32 bytes";
    bytes32 constant STANDARD_STRING_ROLE =
        keccak256(abi.encode(STRING_LITERAL));

    Bytes32RolesRegistry public bytes32RolesRegistry;

    function setUp() public {
        bytes32RolesRegistry = new Bytes32RolesRegistry();
    }

    function test_registerStandardBytes32() public {
        vm.expectEmit(true, true, false, false);
        emit Bytes32RolesRegistry.StandardLabelBytes32(
            STANDARD_BYTES32_STRING_LITERAL_ROLE,
            BYTES32_STRING_LITERAL
        );
        bytes32RolesRegistry.registerStandardBytes32(BYTES32_STRING_LITERAL);
        assertEq(
            bytes32RolesRegistry.standardBytes32(
                STANDARD_BYTES32_STRING_LITERAL_ROLE
            ),
            BYTES32_STRING_LITERAL
        );
    }

    function test_registerStandardBytes32(bytes32 literal) public {
        vm.expectEmit(true, true, false, false);
        bytes32 role = keccak256(abi.encodePacked(literal));
        emit Bytes32RolesRegistry.StandardLabelBytes32(role, literal);
        bytes32RolesRegistry.registerStandardBytes32(literal);
        assertEq(bytes32RolesRegistry.standardBytes32(role), literal);
    }

    function test_labelStandardStringLiteral() public {
        vm.expectEmit(true, true, false, false);
        emit Bytes32RolesRegistry.StandardLabelStringLiteral(
            STANDARD_STRING_ROLE,
            STRING_LITERAL
        );
        bytes32RolesRegistry.registerStandardStringLiteral(STRING_LITERAL);
        assertEq(
            bytes32RolesRegistry.standardStringLiteral(STANDARD_STRING_ROLE),
            STRING_LITERAL
        );
    }

    function test_labelStandardStringLiteral(string memory literal) public {
        vm.expectEmit(true, true, false, false);
        emit Bytes32RolesRegistry.StandardLabelStringLiteral(
            keccak256(abi.encode(literal)),
            literal
        );
        bytes32 role = keccak256(abi.encode(literal));
        bytes32RolesRegistry.registerStandardStringLiteral(literal);
        assertEq(bytes32RolesRegistry.standardStringLiteral(role), literal);
    }
}
