// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Counter.sol";

contract CounterTest is Test {
    Counter public counter;

    function setUp() public {
        counter = new Counter();
    }

    // forge test --match-path=./test/Counter.t.sol -vvvv --match-test=testSetNumber_withAuth
    function testSetNumber_withAuth() public {
        vm.prank(counter.owner());
        (bool success, ) = address(counter).call(abi.encodeWithSignature("setNumber(uint256)", 1));
        assertEq(success, true);
        assertEq(counter.number(), 1);
    }

    // forge test --match-path=./test/Counter.t.sol -vvvv --match-test=testSetNumber_noAuth
    function testSetNumber_noAuth() public {
        vm.expectRevert("onlyOwner");
        (bool success, ) = address(counter).call(abi.encodeWithSignature("setNumber(uint256)", 1));
        assertEq(success, false); // call should fail with revert "onlyOwner", but `success` is true
        assertNotEq(counter.number(), 1);
    }
}
