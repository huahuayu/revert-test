// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Counter {
    address public constant owner = address(0x0);
    uint256 public number;
    function setNumber(uint256 newNumber) public {
        if (msg.sender != owner) {revert("onlyOwner");}
        number = newNumber;
    }
}
