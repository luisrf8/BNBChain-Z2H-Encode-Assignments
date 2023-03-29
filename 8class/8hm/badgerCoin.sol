pragma solidity ^0.8.0;

import "truffle/Assert.sol";
import "../../5HM.sol";

contract TestBadgerCoin {
    BadgerCoin badgerCoin = new BadgerCoin();
    
    function testInitialTotalSupply() public {
        uint256 expected = 1000000 * (10 ** 18);
        uint256 actual = badgerCoin.totalSupply();
        Assert.equal(actual, expected, "Initial total supply should be 1000000");
    }
    
    function testDecimals() public {
        uint8 expected = 18;
        uint8 actual = badgerCoin.decimals();
        Assert.equal(actual, expected, "Number of decimals should be 18");
    }
    
    function testBalanceOf() public {
        address account = address(0x1);
        uint256 expected = 1000 * (10 ** 18);
        badgerCoin.transfer(account, expected);
        uint256 actual = badgerCoin.balanceOf(account);
        Assert.equal(actual, expected, "Balance of account should be 1000");
    }
    
    function testTransfer() public {
        address from = address(0x1);
        address to = address(0x2);
        uint256 amount = 100 * (10 ** 18);
        badgerCoin.transfer(from, amount);
        uint256 balanceBefore = badgerCoin.balanceOf(to);
        badgerCoin.transfer(to, amount);
        uint256 balanceAfter = badgerCoin.balanceOf(to);
        Assert.equal(balanceAfter - balanceBefore, amount, "Transfer should work correctly");
    }
    
    function testTransferWithInsufficientBalance() public {
        address from = address(0x1);
        address to = address(0x2);
        uint256 amount = 2000 * (10 ** 18);
        Assert.revert(badgerCoin.transfer(from, amount), "Transfer should fail with insufficient balance");
    }
}