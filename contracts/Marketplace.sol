pragma solidity ^0.5.11;

import "./Reputation.sol";

contract Marketplace {
    enum ContractState {
        Open,
        InProgress,
        Closed
    }

    struct Contract {
        uint256 remuneration;
        uint256 delay;
        string description;
        ContractState state;
        uint256 minReputation;
        address[] candidates;
    }

    Reputation private _reputation;
    Contract[] private _contracts;
    address payable _owner;

    constructor(Reputation reputation) public {
        _reputation = reputation;
        _owner = msg.sender;
    }

    function addContract(uint256 remuneration, uint256 delay, string memory description, uint256 minReputation) public payable returns(bool){
        require(_reputation.isRegisteredUser(msg.sender), "Unknown user");
        require(_reputation.isBannedUser(msg.sender), "Banned user");
        require(msg.value * 100 >= remuneration * 102, "Funds not sufficient");
        _contracts.push(Contract({
            remuneration: remuneration,
            delay: delay,
            description: description,
            state: ContractState.Open,
            minReputation: minReputation,
            candidates: new address[](0)
        }));
    }

    function getNbContracts() public view returns(uint256) {
        return _contracts.length;
    }

    function getContractDetails(uint256 index) public view returns(uint256, uint256, string memory, ContractState, uint256) {
        return (
            _contracts[index].remuneration,
            _contracts[index].delay,
            _contracts[index].description,
            _contracts[index].state,
            _contracts[index].minReputation
        );
    }
}