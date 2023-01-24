// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Karma {

    // event Transfer(address indexed from, address indexed to, uint256 value);
    // event Mint(address indexed to, uint256 value);

    struct User {
        string nickname;
        uint lastTouchedBlock;
        uint giverTokensBalance;
        uint karmaTokensBalance;
    }

    mapping (address => User) users;

    function setNickname(string calldata nickname) public {
        users[msg.sender].nickname = nickname;
    }

    function mint(address addr) public {
        if(users[addr].lastTouchedBlock != 0){
            users[addr].giverTokensBalance += block.number - users[addr].lastTouchedBlock;
        }
        users[addr].lastTouchedBlock = block.number;
    } 

    function transferKarma(address to, uint amount) public {
        require(users[msg.sender].giverTokensBalance >= amount, "Not enought giver Tokens");
        require(amount > 0, "Negative amount");
        users[msg.sender].giverTokensBalance -= amount;
        users[to].karmaTokensBalance += amount;
    }   

    function getNickname (address addr) public view returns (string memory nickname){
        return users[addr].nickname;
    }

    function getGiverTokensBalace(address addr) public view returns (uint giverBalance) {
        return users[addr].giverTokensBalance;
    }

    function getKarmaTokensBalace(address addr) public view returns (uint karmaBalance) {
        return users[addr].karmaTokensBalance;
    }

    function getLastTouchedBlock (address addr) public view returns (uint lastTouchedBlock){
        return users[addr].lastTouchedBlock;
    }

    function getBlockNum() public view returns (uint blockNum) {
        return block.number;
    }
}
