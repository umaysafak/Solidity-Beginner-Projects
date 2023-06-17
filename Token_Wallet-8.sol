// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// ERC20Token interface
interface ERC20Token {

    // Enables the transfer of a specified amount of tokens to a given address.
    function transfer(address _to, uint256 _value) external returns (bool);

    // Allows approving a specific amount to a specific address.
    function approve(address _spender, uint256 _value) external returns (bool);

    // Transfers a specified amount of tokens from one account to another.
    function transferFrom(address _from, address _to, uint256 _value) external returns (bool);

    // Retrieves the balance of a specific account.
    function balanceOf(address _owner) external view returns (uint256);

}

contract TokenWallet {

    // Address of the contract owner
    address public owner;

    // Reference to the ERC20Token interface of the token
    ERC20Token public token;

    // Transfer and Approval events
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    // Constructor
    constructor(address _tokenAddress) {
        // Set the contract owner and the address of the token to be used
        owner = msg.sender;
        token = ERC20Token(_tokenAddress);
    }

    // Token transfer
    function transfer(address _to, uint256 _value) external returns (bool) {
        // Check for invalid recipient address
        require(_to != address(0), "Invalid recipient address");

        // Perform the token transfer
        bool success = token.transfer(_to, _value);
        require(success, "Token transfer failed");

        // Trigger the Transfer event
        emit Transfer(msg.sender, _to, _value);

        return true;
    }

    // Approval operation
    function approve(address _spender, uint256 _value) external returns (bool) {
        // Check for invalid spender address
        require(_spender != address(0), "Invalid spender address");

        // Perform the approval operation
        bool success = token.approve(_spender, _value);
        require(success, "Approval failed");

        // Trigger the Approval event
        emit Approval(msg.sender, _spender, _value);

        return true;
    }

    // transferFrom operation
    function transferFrom(address _from, address _to, uint256 _value) external returns (bool) {
        // Check for invalid sender and recipient addresses
        require(_from != address(0), "Invalid sender address");
        require(_to != address(0), "Invalid recipient address");

        // Perform the transferFrom operation
        bool success = token.transferFrom(_from, _to, _value);
        require(success, "Token transfer failed");

        // Trigger the Transfer event
        emit Transfer(_from, _to, _value);

        return true;
    }

    // Get wallet balance
    function getBalance() external view returns (uint256) {
        return token.balanceOf(address(this));
    }

    // Token withdrawal
    function withdrawToken(address _to, uint256 _value) external returns (bool) {
        // Only the contract owner can call this function
        require(msg.sender == owner, "Only owner can call this function");

        // Perform the token withdrawal
        bool success = token.transfer(_to, _value);
        require(success, "Token transfer failed");

        // Trigger the Transfer event
        emit Transfer(address(this), _to, _value);

        return true;
    }
}

/*
The above contract provides a complex Token wallet called TokenWallet. This contract interacts with the Token based on the ERC20Token interface.
It can perform token transfers, approval operations, and balance queries. Additionally, the contract owner can withdraw a specific amount of tokens.
*/
