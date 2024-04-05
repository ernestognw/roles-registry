## Access Control Roles Registry

Attempt to make a registry for on-chain registration of roles.

## Problem

One of the most widely used patterns in smart contracts is the role-based access control pattern. However, there is no standard way of identifying roles. Concretely, [OpenZeppelin's official recommendation.](https://docs.openzeppelin.com/contracts/5.x/api/access#AccessControl) suggests to hash a string literal, which disallows for indexers to get the preimage in a constant way.

Recent implementations such as the OpenZeppelin Access Manager use bytes64 roles that can be [labeled through a function](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v5.0.1/contracts/access/manager/AccessManager.sol#L217) that emits an event for off-chain indexers to pick it up, but there's still no interoperability for roles between smart contracts.

## Solution

This repository introduces a Bytes32Roles Registry that stores labels for roles if such label matches the hash representing the role.

## Usage

### Register a role

```solidity
// Hashed bytes32 string literals (<= 32 bytes)
// bytes32 constant ROLE = keccak256("FOO");
function registerStandardBytes32(bytes32 role, string calldata label) external;

// Hashed strings (> 32 bytes)
// bytes32 constant ROLE = keccak256("this is a long string that doesn't fit in 32 bytes");
function registerStandardStringLiteral(bytes32 role, string calldata label) external;
```

### Get a role

```solidity
function standardBytes32(bytes32 role) external view returns (bytes32);
function standardStringLiteral(bytes32 role) external view returns (string memory);
```

### Events

```solidity
event StandardLabelBytes32(bytes32 indexed key, bytes32 value);
event StandardLabelStringLiteral(bytes32 indexed key, string value);
```
