// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract EtherWallet {
    mapping(address => uint256) private balances;
    mapping(address => mapping(address => uint256)) private allowedBalances;

    event TransferMade(address indexed sender, address indexed recipient, uint256 amount);
    event DepositMade(address indexed user, uint256 amount);
    event WithdrawalMade(address indexed user, uint256 amount);
    event ApprovalGranted(address indexed user, uint256 amount);
    event ApprovalRevoked(address indexed user);

    function getBalance() public view returns (uint256) {
        return balances[msg.sender];
    }

    function deposit() public payable {
        balances[msg.sender] += msg.value;
        emit DepositMade(msg.sender, msg.value);
    }

    function withdraw(uint256 _amount) public {
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        balances[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);
        emit WithdrawalMade(msg.sender, _amount);
    }

    function makeTransfer(address _recipient, uint256 _amount) public {
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        balances[msg.sender] -= _amount;
        balances[_recipient] += _amount;
        emit TransferMade(msg.sender, _recipient, _amount);
    }

    function grantApproval(address _user, uint256 _amount) public {
        allowedBalances[msg.sender][_user] = _amount;
        emit ApprovalGranted(_user, _amount);
    }

    function revokeApproval(address _user) public {
        delete allowedBalances[msg.sender][_user];
        emit ApprovalRevoked(_user);
    }

    function transferByAuthorized(address _sender, address _recipient, uint256 _amount) public {
        require(allowedBalances[_sender][msg.sender] >= _amount, "Insufficient authorized transfer amount");
        allowedBalances[_sender][msg.sender] -= _amount;
        balances[_sender] -= _amount;
        balances[_recipient] += _amount;
        emit TransferMade(_sender, _recipient, _amount);
    }
}

/*
This Ether Wallet project provides advanced wallet functionality in Solidity. Inside the contract, two mappings named 'balances' and 'allowedBalances' are defined.

The 'getBalance' function allows users to view their wallet balance.

The 'deposit' function allows users to deposit Ether into their wallet. The deposited Ether amount is added to the user's balance. The 'DepositMade' event is emitted.

The 'withdraw' function allows users to withdraw Ether from their wallet. The requested Ether amount is deducted from the user's balance and transferred to their address. The 'WithdrawalMade' event is emitted.

The 'makeTransfer' function allows users to transfer Ether to another address.

The 'grantApproval' function allows users to grant permission to another user to transfer a certain amount of Ether on their behalf. The 'ApprovalGranted' event is emitted.

The 'revokeApproval' function allows users to revoke the transfer permission of another user. The 'ApprovalRevoked' event is emitted.

The 'transferByAuthorized' function allows users to make an authorized transfer of Ether on behalf of another user.
This operation can only be performed by an authorized transfer agent. The 'TransferMade' event is emitted.

This project allows users to store, withdraw, and transfer Ether, while also providing functionality for granting and revoking transfer authorization.
Users can manage their transfers by authorizing another user to handle a specific amount of Ether.
*/
