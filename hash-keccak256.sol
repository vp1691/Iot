pragma solidity >= 0.8.6;

contract hashData{
    function getHash(string memory _data) public pure returns(bytes32){
        return keccak256(abi.encode(_data));
    }
}
