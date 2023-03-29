// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

import  "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import  "@openzeppelin/contracts/access/Ownable.sol";

contract DummyContract is ERC20, Ownable {
    uint constant INITIAL_AMOUNT = 100;

    constructor() ERC20("DummyToken", "DumTkn") {}

    function setup() external onlyOwner {
        _mint(msg.sender, INITIAL_AMOUNT);
    }
}