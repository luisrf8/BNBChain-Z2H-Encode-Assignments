// Homework 4
// Solidity
// To this contract
// 1. Add a variable to hold the address of the deployer of the contract
// 2. Update that variable with the deployer's address when the contract is
// deployed.
// 3. Write an external function to return
// 1. Address 0x000000000000000000000000000000000000dEaD if called by
// the deployer
// 2. The deployer's address otherwise

// SPDX-License-Identifier: None

pragma solidity 0.8.18;


contract BootcampContract {

    uint256 number;
    address public deployer; 
    constructor () {
        deployer=msg.sender;
    }
    function store(uint256 num) public {
        number = num;
    }
    function retrieve()  public view returns (uint256) {
        return number;
    }

    function getAddress() external view returns (address){
        if(msg.sender == deployer) {
            return address(0x000000000000000000000000000000000000dEaD);
        }
        else {
            return deployer;
        }
    }
}

// 2nd part 

// SPDX-License-Identifier: UNLICENSED .

// pragma solidity 0.8.18;

// contract DogCoin {
//     uint256 public totalSupply; 
//     address owner;
    
//     constructor() {
//         totalSupply = 2000000;
//         owner = msg.sender;
//         balances[owner] = totalSupply;
//     }
//     event thousandAdded(uint256);
//     event Transfer(address, address, uint256);

//     struct Payment {
//         address recipient;
//         uint256 amount;
//     }

//     mapping(address => uint256) public balances;
//     mapping(address => Payment[]) public payments;

//     modifier onlyOwner {
//         require(msg.sender == owner);
//         _;
//     }
//     function addressBalance(address _address) public view returns (uint256) {
//         return balances[_address];
//     }
//     function getTotalSupply () public view returns (uint256) {
//         return totalSupply;
//     }

//     function addThousand () public onlyOwner {
//         totalSupply = totalSupply + 1000;
//         emit thousandAdded(totalSupply);
//     }
//     function transfer(address _address, uint256 _amount) public {
//         require (balances[msg.sender] >= _amount, "Isufficient Balances");
//         balances[msg.sender] -= _amount;
//         balances[_address] += _amount;
//         payments[msg.sender].push(Payment(_address, _amount));
//         emit Transfer(msg.sender, _address, _amount);
//     }

// }

//homework 10 

// SPDX-License-Identifier: UNLICENSED .

pragma solidity 0.8.18;

contract DogCoin {
uint256 public totalSupply;
address owner;

constructor() {
    totalSupply = 2000000;
    owner = msg.sender;
    balances[owner] = totalSupply;
}

event thousandAdded(uint256);
event Transfer(address, address, uint256);

struct Payment {
    address recipient;
    uint256 amount;
}

mapping(address => uint256) public balances;
mapping(address => Payment[]) public payments;

modifier onlyOwner {
    require(msg.sender == owner, "Only the owner can call this function.");
    _;
}

function addressBalance(address _address) public view returns (uint256) {
    return balances[_address];
}

function getTotalSupply () public view returns (uint256) {
    return totalSupply;
}

function _mint(uint256 _amount) internal {
    totalSupply = totalSupply + _amount;
    balances[owner] = balances[owner] + _amount;
}

function addThousand() public onlyOwner {
    _mint(1000);
    emit thousandAdded(totalSupply);
}

function transfer(address _address, uint256 _amount) public {
    require(balances[msg.sender] >= _amount, "Insufficient balance.");
    balances[msg.sender] -= _amount;
    balances[_address] += _amount;
    payments[msg.sender].push(Payment(_address, _amount));
    emit Transfer(msg.sender, _address, _amount);
}
}

// Unit Tests

pragma solidity ^0.8.0;

import "truffle/Assert.sol";
import "../contracts/DogCoin.sol";

contract TestDogCoin {
DogCoin dogCoin = new DogCoin();
uint256 expectedSupply = 2000000;
address owner = address(this);
address recipient = address(0x123);
uint256 amount = 1000;

function testInitialBalance() public {
    uint256 expectedBalance = 2000000;
    uint256 balance = dogCoin.addressBalance(owner);
    Assert.equal(balance, expectedBalance, "Initial balance is incorrect.");
}

function testTotalSupply() public {
    uint256 supply = dogCoin.getTotalSupply();
    Assert.equal(supply, expectedSupply, "Initial total supply is incorrect.");
}

function testAddThousand() public {
    dogCoin.addThousand();
    expectedSupply = expectedSupply + 1000;
    uint256 supply = dogCoin.getTotalSupply();
    Assert.equal(supply, expectedSupply, "Total supply was not increased by 1000.");
}

function testTransfer() public {
    uint256 senderBalanceBefore = dogCoin.addressBalance(owner);
    uint256 recipientBalanceBefore = dogCoin.addressBalance(recipient);
    dogCoin.transfer(recipient, amount);
    uint256 senderBalanceAfter = dogCoin.addressBalance(owner);
    uint256 recipientBalanceAfter = dogCoin.addressBalance(recipient);
    
    Assert.equal(senderBalanceAfter, senderBalanceBefore - amount, "Sender balance was not correctly updated.");
    Assert.equal(recipientBalanceAfter, recipientBalanceBefore + amount, "Recipient balance was not correctly updated.");
}
}