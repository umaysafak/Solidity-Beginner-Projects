// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract MultiSender {
    function send(address[] memory _recipients, uint256[] memory _amounts) external payable {
    require(_recipients.length == _amounts.length, "Recipient and amount count mismatch");

    uint256 totalAmount = 0;

        for (uint256 i = 0; i < _recipients.length; i++) {
            totalAmount += _amounts[i];
        }

    require(msg.value >= totalAmount, "Insufficient Ether sent");

        for (uint256 i = 0; i < _recipients.length; i++) {
            payable(_recipients[i]).transfer(_amounts[i]);
        }
    }
}

/*
This MultiSender project allows for sending Ether to multiple addresses in Solidity. The contract defines a send function.

The send function takes two array parameters: _recipients and _amounts. The _recipients array contains the addresses to which the Ether will be sent, and the _amounts array contains the corresponding amounts of Ether to be sent to each address. There should be a mapping between the addresses in _recipients and the amounts in _amounts.

The function verifies that the lengths of the _recipients and _amounts arrays match, ensuring that there is a consistent mapping. It then calculates the total amount of Ether to be sent using a loop.

The msg.value expression represents the amount of Ether sent by the calling address. The msg.value should be greater than or equal to the total amount of Ether to be sent; otherwise, the transaction will revert with an error.

Finally, using a loop, the function sends the specified amounts of Ether to each recipient address. The payable keyword indicates that the recipient address can receive Ether.

This project enables the sender to send Ether to multiple addresses in a batch and verifies the total amount of Ether sent.
*/
