// Create an BEP20 contract with the following details :
// Name : "BadgerCoin"
// Symbol : "BC"
// Decimals : 18
// Initial supply : 1000000 tokens

// Response

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts@4.8.2/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@4.8.2/access/Ownable.sol";

contract BadgerCoin is ERC20, Ownable {
    constructor() ERC20("BadgerCoin", "BC") {
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }
}

https://testnet.bscscan.com/token/0x18ac0c304fa881fa33d92e3631d2a655cc2db1e6