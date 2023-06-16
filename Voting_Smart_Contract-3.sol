
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Voting {

    struct Vote {
        address voter;
        uint256 choice;
    }

    enum Option {Yes, No}

    mapping(uint256 => Vote[]) private votes;
    uint256 private votingPeriod;
    uint256 private startTime;
    uint256 private optionCount;

    event Voted(address indexed voter, uint256 indexed choice);

    constructor(uint256 _votingPeriod, uint256 _optionCount) {
        votingPeriod = _votingPeriod;
        startTime = block.timestamp;
        optionCount = _optionCount;
    }

    modifier withinVotingPeriod() {
        require(block.timestamp < startTime + votingPeriod, "Voting period has ended");
        _;
    }

    function vote(uint256 _choice) public withinVotingPeriod {
        require(_choice < optionCount, "Invalid choice");
        votes[_choice].push(Vote(msg.sender, _choice));
        emit Voted(msg.sender, _choice);
    }

    function voteCount(uint256 _choice) public view returns (uint256) {
        require(_choice < optionCount, "Invalid choice");
        return votes[_choice].length;
    }
}
/*
This Smart Contract Voting project creates a voting mechanism in Solidity. Inside the contract, there is a structure named 'Vote' and a mapping named 'votes'.

The 'Vote' structure contains the address of the voter and the index of their choice. This structure represents each voting action.

The 'votes' mapping maps choice indexes to 'Vote' structures. It stores the votes for each option.

The contract also includes variables named 'votingPeriod', 'startTime', and 'optionCount'. The votingPeriod variable determines how long the voting will last.
The startTime variable represents the starting time of the voting. The optionCount variable specifies the number of options in the voting.

The 'withinVotingPeriod' modifier checks if the current timestamp is within the voting period. This modifier ensures that voting operations are only performed during the voting period.

The 'vote' function allows users to cast their votes. The given vote is recorded in the votes mapping based on the corresponding choice index.
Additionally, the 'Voted' event is emitted.

The 'voteCount' function returns the number of votes for a specific choice.

This Smart Contract Voting project enables users to vote within a certain period of time and stores the cast votes.
Votes are recorded separately for each option, allowing for statistical analysis of the voting results.
*/
