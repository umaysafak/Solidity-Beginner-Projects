// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract TimeLock {
    struct Lock {
        uint256 releaseTime;
        uint256 lockAmount;
        bool released;
    }

    mapping(address => Lock) public locks;

    event LockCreated(address indexed beneficiary, uint256 releaseTime, uint256 lockAmount);
    event LockReleased(address indexed beneficiary, uint256 amount);

    function createLock(address beneficiary, uint256 releaseTime, uint256 lockAmount) external payable {
        require(releaseTime > block.timestamp, "Release time must be in the future");
        require(lockAmount > 0, "Lock amount must be greater than zero");

        Lock storage newLock = locks[beneficiary];
        require(!newLock.released, "Lock already released");

        newLock.releaseTime = releaseTime;
        newLock.lockAmount = lockAmount;
        newLock.released = false;

        emit LockCreated(beneficiary, releaseTime, lockAmount);
    }

    function releaseLock() external {
        Lock storage userLock = locks[msg.sender];
        require(!userLock.released, "Lock already released");
        require(block.timestamp >= userLock.releaseTime, "Release time has not yet arrived");

        uint256 amount = userLock.lockAmount;
        userLock.released = true;

        emit LockReleased(msg.sender, amount);

        payable(msg.sender).transfer(amount);
}

/*
This TimeLock Smart Contract includes the following features:

Lock structure: It includes releaseTime (time of release), lockAmount (amount locked), and released (whether it has been released or not) fields, representing a new lock.
locks mapping: It maps each user's address to a lock. Each user can have only one lock.
LockCreated event: It is triggered when a new lock is created and records the relevant information.
LockReleased event: It is triggered when a lock is released and records the relevant information.
The contract includes the following functions:

createLock function: It allows for creating a new lock. It takes beneficiary (the recipient), releaseTime (the time of release), and lockAmount (the locked amount) as parameters.
This function adds a new lock to the mapping and triggers the LockCreated event.
releaseLock function: It releases a user's lock. The user must have an unreleased lock and the release time must have arrived.
It marks the lock as released, triggers the LockReleased event, and transfers the locked amount to the user's address.
*/
