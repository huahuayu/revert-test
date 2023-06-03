
## Contract

```solidity
contract Counter {
    address public constant owner = address(0x0);
    uint256 public number;
    function setNumber(uint256 newNumber) public {
        if (msg.sender != owner) {revert("onlyOwner");}
        number = newNumber;
    }
}
```

## Test functions

### Test case 1

Use `vm.prank` to change `msg.sender` to `owner` and call `setNumber` function, it should be success.

```solidity
    function testSetNumber_withAuth() public {
        vm.prank(counter.owner());
        (bool success, ) = address(counter).call(abi.encodeWithSignature("setNumber(uint256)", 1));
        assertEq(success, true);
        assertEq(counter.number(), 1);
    }
```

### Test case 2

Do not use `vm.prank` to change `msg.sender`, it should be failed with `onlyOwner` revert message.

```solidity
    function testSetNumber_noAuth() public {
    vm.expectRevert("onlyOwner");
    (bool success, ) = address(counter).call(abi.encodeWithSignature("setNumber(uint256)", 1));
    assertEq(success, false); // call should fail with revert "onlyOwner", but `success` is true
    assertNotEq(counter.number(), 1);
}
```

But the result is unexpected, `success` is `true`, which make the test failed, I can't understand why it is `true`.