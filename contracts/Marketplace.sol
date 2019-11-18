pragma solidity ^0.5.11;

import "./Reputation.sol";

contract Marketplace {
    enum ContractState {
        Open,
        InProgress,
        Closed
    }

    struct Demand {
        uint256 remuneration;
        uint256 delay;
        string description;
        ContractState state;
        uint256 minReputation;
        address[] candidates;
        uint startDate;
    }

    Reputation private _reputation;
    Demand[] private _demands;
    address payable _owner;

    constructor(Reputation reputation) public {
        _reputation = reputation;
        _owner = msg.sender;
    }

    function addContract(uint256 remuneration, uint256 delay, string memory description, uint256 minReputation) public payable returns(bool){
        require(_reputation.isRegisteredUser(msg.sender), "Unknown user");
        require(_reputation.isBannedUser(msg.sender), "Banned user");
        require(msg.value * 100 >= remuneration * 102, "Funds not sufficient");
        _demands.push(Demand({
            remuneration: remuneration,
            delay: delay,
            description: description,
            state: ContractState.Open,
            minReputation: minReputation,
            candidates: new address[](0),
            startDate: 0
        }));
    }

    function getNbDemands() public view returns(uint256) {
        return _demands.length;
    }

    function getDemandDetails(uint256 index) public view returns(uint256, uint256, string memory, ContractState, uint256) {
        return (
            _demands[index].remuneration,
            _demands[index].delay,
            _demands[index].description,
            _demands[index].state,
            _demands[index].minReputation
        );
    }
}