pragma solidity ^0.5.11;

contract Administrable {
    mapping(address => bool) private _admins;
    uint256 private _nbAdmins;

    constructor() public {
        _admins[msg.sender] = true;
        _nbAdmins++;
    }

    modifier onlyAdmin() {
        require(_admins[msg.sender], "Not an admin.");
        _;
    }

    function addAdmin(address admin) public onlyAdmin {
        _admins[admin] = true;
        _nbAdmins++;
    }

    function resignAdmin() public onlyAdmin {
        require(_nbAdmins > 1, "Last admin cannot resign.");
        _admins[msg.sender] = false;
    }
}