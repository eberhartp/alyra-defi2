pragma solidity ^0.5.11;

import "./Administrable.sol";

contract Reputation is Administrable {
    struct User {
        bool registered;
        string name;
        uint256 reputation;
        bool banned;
    }

    mapping(address => User) private _users;
    address[] private _userAddresses;

    function registration(string memory name) public {
        require(!_users[msg.sender].registered, "User already registered");
        require(!_users[msg.sender].banned, "User banned");
        _users[msg.sender].reputation = 1;
        _users[msg.sender].name = name;
        _users[msg.sender].registered = true;
        _userAddresses.push(msg.sender);
    }

    function isRegisteredUser(address user) public view returns(bool) {
        return _users[user].registered;
    }

    function isBannedUser(address user) public view returns(bool) {
        return _users[user].banned;
    }

    function getUsersCount() public view returns(uint256) {
        return _userAddresses.length;
    }

    function getUserAddress(uint256 index) public view returns(address) {
        return _userAddresses[index];
    }

    function getUserDetails(address user) public view returns(string memory, uint256, bool) {
        return (_users[user].name, _users[user].reputation, _users[user].banned);
    }

    function banUser(address user) public onlyAdmin {
        require(_users[user].registered, "Unknown user");
        require(!_users[user].banned, "User already banned");
        _users[user].banned = true;
        _users[user].reputation = 0;
    }

    function unbanUser(address user) public onlyAdmin {
        require(_users[user].registered, "Unknown user");
        require(_users[user].banned, "User not banned");
        _users[user].banned = false;
        _users[user].reputation = 1;
    }
}