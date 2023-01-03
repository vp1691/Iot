pragma solidity ^0.4.26;
contract MyContract{
    address private owner;

    constructor() public{
        owner=msg.sender;

    }

    function getOwner() public view returns(address){
        return owner;
    }

    function getBalance() public view returns(uint256){
        return owner.balance;
    }
}
