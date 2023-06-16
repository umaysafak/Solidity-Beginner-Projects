// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract HelloWorld {
    string public message;

    constructor() {
        message = "Hello, World!";
    }

    function setMessage(string memory _newMessage) public {
        message = _newMessage;
    }

    function getMessage() public view returns (string memory) {
        return message;
    }
}

/*
This simple "Hello, World!" project creates a smart contract in Solidity. Inside the contract, there is a variable named 'message' which is initialized with the value "Hello, World!".

The contract also has 'setMessage' and 'getMessage' functions. 'setMessage' function is used to update the value of the 'message' variable through the parameter '_newMessage'.
'getMessage' function is used to read the value of the 'message' variable.

When this contract is deployed, it returns "Hello, World!" as the default message. However, users can update the message as they wish using the 'setMessage' function.
'getMessage' function can be used to read the current message.

This project serves as a basic example for learning Solidity and demonstrates the fundamental principles of creating a smart contract.
*/
