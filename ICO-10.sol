// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract ICO {
    address public owner; // Address of the contract owner
    address public token; // Address of the token
    uint256 public tokenPrice; // Price of the token
    uint256 public totalTokens; // Total token amount
    uint256 public totalSold; // Total tokens sold
    mapping(address => uint256) public balances;          // Mapping to store user token balances

    event TokenPurchased(address indexed buyer, uint256 amount, uint256 totalCost);

    constructor(address _tokenAddress, uint256 _tokenPrice, uint256 _totalTokens) {
        owner = msg.sender;                  // The contract owner is assigned as the msg.sender when the contract is deployed
        token = _tokenAddress;                // The token address is set to the specified value when the contract is deployed
        tokenPrice = _tokenPrice;             // The token price is set to the specified value when the contract is deployed
        totalTokens = _totalTokens;           // The total token amount is set to the specified value when the contract is deployed
        totalSold = 0;
    }

    function buyTokens(uint256 _amount) external payable {
        require(_amount > 0, "Token amount must be greater than zero");
        require(totalSold + _amount <= totalTokens, "Insufficient tokens available for sale");

        uint256 cost = _amount * tokenPrice;
        require(msg.value >= cost, "Insufficient funds");

        balances[msg.sender] += _amount;
        totalSold += _amount;

        (bool success, ) = payable(owner).call{value: cost}("");
        require(success, "Payment failed");

        emit TokenPurchased(msg.sender, _amount, cost);
    }

    function withdrawTokens(uint256 _amount) external {
        require(balances[msg.sender] >= _amount, "Insufficient token balance");

        balances[msg.sender] -= _amount;
        totalSold -= _amount;

        (bool success, ) = payable(msg.sender).call{value: _amount * tokenPrice}("");
        require(success, "Token withdrawal failed");
    }

    function getBalance() external view returns (uint256) {
        return balances[msg.sender];
    }
}


/*
This contract is an Ethereum smart contract used for conducting an ICO (Initial Coin Offering), which is a token sale process.
Below is a detailed description of the contract:

owner: A variable representing the Ethereum address of the contract owner. The contract owner is the person who creates the contract.

token: A variable representing the Ethereum address of the token. This address refers to the address of the smart contract where the token being offered for sale is located.

tokenPrice: A variable representing the price of the token for sale. The token price is the value set when the contract is created.

totalTokens: A variable representing the total number of tokens. This value indicates the total number of tokens set when the contract is created.

totalSold: A variable representing the total number of tokens sold. This value represents the total amount of tokens purchased.

balances: A mapping that stores the token balances of users. Each user's Ethereum address is associated with a value representing the amount of tokens they own.

TokenPurchased event: An event triggered when tokens are purchased. This event includes the address of the buyer, the amount of tokens purchased, and the total cost.

constructor: A function that runs when the contract is created. It sets the contract owner, token address, token price, and total token amount based on the specified values.

buyTokens function: A function that allows users to purchase tokens. Users can buy a specified amount of tokens by making a payment. If the purchase is successful, the user's balance is updated, the total tokens sold is increased, and the payment is transferred to the contract owner.

withdrawTokens function: A function that allows users to withdraw their tokens. Users can withdraw a specified amount of tokens and receive payment in return. If the withdrawal is successful, the user's balance is updated, and the payment is transferred to the user.

getBalance function: A function that returns the token balance of the caller. Users can use this function to check their own balances.

This contract provides basic functions for an ICO: users can buy tokens, withdraw the tokens they purchased, and check their balances.
The contract owner receives payments from token sales and updates user token balances.
*/
