// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract ERC20Token {
    // Token name
    string public name;

    // Token symbol
    string public symbol;

    // Token decimal places
    uint8 public decimals;

    // Total token supply
    uint256 public totalSupply;

    // Mapping of addresses to their balances
    mapping(address => uint256) public balanceOf;

    // Mapping of allowances between addresses
    mapping(address => mapping(address => uint256)) public allowance;

    // Transfer event
    event Transfer(address indexed from, address indexed to, uint256 value);

    // Approval event
    event Approval(address indexed owner, address indexed spender, uint256 value);

    // Burn event
    event Burn(address indexed from, uint256 value);

    // Constructor function executed when the contract is created
    constructor(
        string memory _name,
        string memory _symbol,
        uint8 _decimals,
        uint256 _totalSupply
    ) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _totalSupply;

        // Set the contract creator's balance equal to the total supply
        balanceOf[msg.sender] = _totalSupply;
    }

    // Function for transferring tokens
    function transfer(address _to, uint256 _value) external returns (bool) {
        // Check for valid recipient address
        require(_to != address(0), "Invalid recipient address");

        // Check if the sender has sufficient balance
        require(_value <= balanceOf[msg.sender], "Insufficient balance");

        // Subtract the value from the sender's balance and add it to the recipient's balance
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;

        // Trigger the Transfer event
        emit Transfer(msg.sender, _to, _value);

        return true;
    }

    // Function for approving an allowance
    function approve(address _spender, uint256 _value) external returns (bool) {
        // Update the value in the allowance mapping
        allowance[msg.sender][_spender] = _value;

        // Trigger the Approval event
        emit Approval(msg.sender, _spender, _value);

        return true;
    }

    // Function for transferring tokens from a delegated account
    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) external returns (bool) {
        // Check for valid recipient address
        require(_to != address(0), "Invalid recipient address");

        // Check if the sender has sufficient balance
        require(_value <= balanceOf[_from], "Insufficient balance");

        // Check if the allowance amount is sufficient
        require(_value <= allowance[_from][msg.sender], "Insufficient allowance");

        // Subtract the value from the sender's balance, add it to the recipient's balance, and reduce the allowance amount
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        allowance[_from][msg.sender] -= _value;

        // Trigger the Transfer event
        emit Transfer(_from, _to, _value);

        return true;
    }

    // Function for burning tokens
    function burn(uint256 _value) external returns (bool) {
        // Check if the sender has sufficient balance
        require(_value <= balanceOf[msg.sender], "Insufficient balance");

        // Subtract the value from the sender's balance and reduce the total supply
        balanceOf[msg.sender] -= _value;
        totalSupply -= _value;

        // Trigger the Burn event
        emit Burn(msg.sender, _value);

        return true;
    }
}

/*
This ERC-20 token contract can be used to build the foundation of a token-based ecosystem.
The contract has variables to hold the token's name, symbol, decimal places, and total supply.
It also includes mappings to track the balances of each address and the amounts authorized between addresses.

The contract has functions to perform token transfers, allowance approvals, and token burning.
These functions check if the sender has sufficient balance and authorization, and update the balances accordingly.
Events like Transfer, Approval, and Burn are emitted to track token transfers, allowance approvals, and token burnings.

This ERC-20 token contract enables the development of advanced token-based applications.
It includes additional functions like allowance approvals and token burning to accommodate different scenarios,
making it suitable for creating more complex token-based applications.
*/
