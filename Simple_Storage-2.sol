/ SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Storage {
    struct Data {
        string name;
        uint value;
     }

    mapping(uint => Data) public data;
    uint public dataCount;

    function addData(string memory _name, uint _value) public {
        data[dataCount] = Data(_name, _value);
        dataCount++;
    }

    function getData(uint _index) public view returns (string memory, uint) {
        require(_index < dataCount, "Invalid data index");
        Data memory targetData = data[_index];
        return (targetData.name, targetData.value);
    }
}

/*
This simple storage project creates a smart contract in Solidity. Inside the contract, there is a structure named 'Data' and a mapping named 'data'.

The 'Data' structure contains two properties of a data record: name (string type) and value (uint type). This structure is used to store different data.

The 'data' mapping maps data indexes to 'Data' structures. Each data record has a unique index.

The contract also includes a variable named 'dataCount'. This variable is used to track the current number of data records.

The 'addData' function is used by users to add a new data record. This function creates a new 'Data' structure using the '_name' and '_value' parameters and saves it to the 'data' mapping.
It also updates the 'dataCount' variable.

The 'getData' function is used to retrieve a 'Data' structure with a specific data index. Users can retrieve the desired data record using the '_index' parameter.
The function checks the validity of the data index and returns the 'Data' structure associated with the provided index.

This simple yet complex storage project demonstrates further data manipulation and control in Solidity.
Users can add new data records through the 'addData' function and access the saved data using the 'getData' function.
Such a storage mechanism can be utilized in the development of more sophisticated smart contracts and support various scenarios for data management.
*/
