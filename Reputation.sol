pragma solidity ^0.5.11;

import "./Administrable.sol";

contract Reputation is Administrable {
    mapping(address => uint256) private _reputations;
    mapping(address => string) private _names;
    mapping(address => bool) private _users;
    mapping(address => bool) private _bannedUsers;

    function registration(string memory name) public {
        require(!_users[msg.sender], "User already registered");
        require(!_bannedUsers[msg.sender], "User banned");
        _users[msg.sender] = true;
        _reputations[msg.sender] = 1;
        _names[msg.sender] = name;
    }

    function banUser(address user) public onlyAdmin {
        require(_users[user], "Unknown user");
        require(!_bannedUsers[user], "User already banned");
        _bannedUsers[user] = true;
        _reputations[user] = 0;
    }

    function unbanUser(address user) public onlyAdmin {
        require(_users[user], "Unknown user");
        require(_bannedUsers[user], "User not banned");
        _bannedUsers[user] = false;
        _reputations[user] = 1;
    }
}