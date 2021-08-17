//"SPDX-License-Identifier: UNLICENSED"
pragma solidity 0.7.3;

import 'hardhat/console.sol';

contract Token{
    string public tokenName;
    address public owner;
    mapping (address => uint) public balances;

    modifier mustBeOwner {
        require(msg.sender == owner, "only the owner can call this function");
        _;
    }

    constructor(){
        tokenName = "My Token";
        owner = msg.sender;
        console.log("Token Name: %s \nOwner Address: %s\n", tokenName, owner);
    }

    function mint(uint _amount) public mustBeOwner {
        balances[msg.sender] += _amount;
        console.log("Owner minted %d Token(s)\n", _amount);
    }

    function send(address reciever, uint _amount) public {
        require(balances[msg.sender] >= _amount, "insufficient balance");
        console.log("Balances before: %d %d\n", balances[msg.sender], balances[reciever]);
        console.log("Amount to be sent: %d\n", _amount);
        balances[msg.sender] -= _amount;
        balances[reciever] += _amount;
        console.log("Balances after: %d %d\n", balances[msg.sender], balances[reciever]);
    }

    function balanceOf(address user) public view returns(uint){
        return balances[user];
    }
}