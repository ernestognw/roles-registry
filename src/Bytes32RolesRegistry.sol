// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

/// @notice A universal registry for `bytes32` roles.
/// @dev Supports roles declared as hashed strings, following
/// [OpenZeppelin's official recommendation.](https://docs.openzeppelin.com/contracts/5.x/api/access#AccessControl)
///
///   ``` solidity
///   // Hashed bytes32 string literals (<= 32 bytes)
///   bytes32 constant ROLE = keccak256("FOO");
///   // Hashed strings (> 32 bytes)
///   bytes32 constant ROLE = keccak256("this is a long string that doesn't fit in 32 bytes");
///   ```
contract Bytes32RolesRegistry {
    /// @notice A mapping of standard roles to their corresponding bytes32 string literal labels.
    /// `bytes32 constant ROLE = keccak256("FOO");`
    mapping(bytes32 role => bytes32 label) public standardBytes32;

    /// @notice A mapping of standard roles to their corresponding string labels.
    /// `bytes32 constant ROLE = keccak256("this is a long string that doesn't fit in 32 bytes");`
    mapping(bytes32 role => string label) public standardStringLiteral;

    /// @notice Emitted when a standard role is labeled to their bytes32 string literal label.
    /// @dev Labeled roles MAY be also registered on-chain.
    event StandardLabelBytes32(bytes32 indexed role, bytes32 value);

    /// @notice Emitted when a standard role is labeled to their string label.
    /// @dev Labeled roles MAY be also registered on-chain.
    event StandardLabelStringLiteral(bytes32 indexed role, string value);

    /// @notice Registers a standard bytes32 role label.
    function registerStandardBytes32(bytes32 label) external {
        bytes32 role = keccak256(abi.encode(label));
        standardBytes32[role] = label;
        _labelStandardBytes32(role, label);
    }

    /// @notice Emits an event for a standard bytes32 role label.
    function labelStandardBytes32(bytes32 label) external {
        _labelStandardBytes32(keccak256(abi.encode(label)), label);
    }

    function _labelStandardBytes32(bytes32 role, bytes32 label) internal {
        emit StandardLabelBytes32(role, label);
    }

    /// @notice Registers a standard string role label.
    function registerStandardStringLiteral(string calldata label) external {
        bytes32 role = keccak256(abi.encode(label));
        standardStringLiteral[role] = label;
        _labelStandardStringLiteral(role, label);
    }

    /// @notice Emits an event for a standard string role label.
    function labelStandardStringLiteral(string calldata label) external {
        _labelStandardStringLiteral(keccak256(abi.encode(label)), label);
    }

    function _labelStandardStringLiteral(
        bytes32 role,
        string memory label
    ) internal {
        emit StandardLabelStringLiteral(role, label);
    }
}
