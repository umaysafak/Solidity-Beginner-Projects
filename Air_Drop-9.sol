// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Airdrop {

    address public owner; // Address of the contract owner
    uint256 public totalTokens; // Total token amount
    mapping(address => uint256) public airdropTokens; // Mapping to store the amount of tokens each address will receive
    mapping(address => bool) public hasClaimed; // Mapping to track if an address has claimed tokens

    event AirdropTokensDistributed(address indexed recipient, uint256 amount);       // Event triggered when tokens are distributed
    event AirdropTokensClaimed(address indexed recipient, uint256 amount);           // Event triggered when tokens are claimed

    constructor(uint256 _totalTokens) {
        owner = msg.sender;                      // The contract owner is assigned as the msg.sender when the contract is deployed
        totalTokens = _totalTokens;               // The total token amount is set to the specified value when the contract is deployed
    }

    function distributeTokens(address[] calldata _recipients, uint256[] calldata _amounts) external {
        require(msg.sender == owner, "Only the owner can distribute tokens");          // Only the contract owner can distribute tokens
        require(_recipients.length == _amounts.length, "Recipient and amount count mismatch");     // The number of addresses and amounts should match

        uint256 totalAmount = 0;

        for (uint256 i = 0; i < _recipients.length; i++) {
            require(!hasClaimed[_recipients[i]], "Recipient has already claimed tokens");   // Recipients should not have claimed tokens before

            airdropTokens[_recipients[i]] = _amounts[i];     // Store the token amount for the recipient
            totalAmount += _amounts[i];                       // Update the total distributed token amount

            emit AirdropTokensDistributed(_recipients[i], _amounts[i]);      // Trigger the event for the distribution
        }

        require(totalAmount <= totalTokens, "Insufficient tokens for distribution");   // There should be enough tokens for distribution
        totalTokens -= totalAmount;                            // Deduct the distributed token amount from the total token amount
    }

    function claimTokens() external {
        require(airdropTokens[msg.sender] > 0, "No tokens available for claim");           // There should be tokens available for claim
        require(!hasClaimed[msg.sender], "Tokens have already been claimed");               // Tokens should not have been claimed before

        uint256 amount = airdropTokens[msg.sender];                    // Get the claimed token amount
        airdropTokens[msg.sender] = 0;                                 // Reset the claimed token amount
        hasClaimed[msg.sender] = true;                                  // Mark the tokens as claimed
        totalTokens -= amount;                                          // Deduct the claimed amount from the total token amount

        emit AirdropTokensClaimed(msg.sender, amount);                   // Trigger the event for the token claim
    }
}

/*
The above contract represents a complex Airdrop project. This contract allows a contract owner to distribute a specified amount of tokens to specified addresses and enables users to claim those tokens.

The main functions of the contract are as follows:

distributeTokens: An external function that can only be called by the contract owner to distribute a certain amount of tokens to a specific address.
The distribution is performed through the _recipients and _amounts arrays. During the distribution, the token amount for each recipient is stored in the airdropTokens mapping at the corresponding indexes of _recipients and _amounts arrays.
Additionally, the total token amount is updated, and the AirdropTokensDistributed event is triggered for each distribution.

claimTokens: An external function that allows users to claim the tokens. Users must have a predefined amount of tokens to be eligible for claiming.
This function resets the claimed token amount in the airdropTokens mapping, updates the hasClaimed mapping, deducts the claimed amount from the total token amount, and triggers the AirdropTokensClaimed event.

This way, a Solidity contract representing a complex Airdrop project has been provided. This contract can distribute tokens to specific addresses and allow users to claim those tokens.
*/
