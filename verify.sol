// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

 
contract verifySign{
    function getMessageHash(
        address _to,
        uint _amt,
        string memory _msg,
        uint _nonce
    ) public pure returns (bytes32){
        return keccak256(abi.encodePacked(_to,_amt,_msg,_nonce));
    }

    function getEthSignedMessageHash(
        bytes32 _msgHash
    ) public pure returns (bytes32){
        return keccak256(abi.encodePacked("\x19 Eth Signed Message :\n32",_msgHash));
    }

    function verify(
        address _signer,
        address _to,
        uint _amt,
        string memory _msg,
        uint _nonce,
        bytes memory signature
    ) public pure returns (bool){
    bytes32 messageHash=getMessageHash(_to,_amt,_msg,_nonce);
    bytes32 ethSignedMessageHash=getEthSignedMessageHash(messageHash);
    return recoverSigner(ethSignedMessageHash,signature)== _signer;
    }

    function recoverSigner(
        bytes32 _ethSignedMessageHash,
        bytes memory _signature
    ) public pure returns (address){
        (bytes32 r, bytes32 s, uint8 v)= splitSignature(_signature);
        return ecrecover(_ethSignedMessageHash,v,r,s);
    }

    function splitSignature(
        bytes memory sign
    ) public pure returns(bytes32 r, bytes32 s, uint8 v){
        require(sign.length==65, "invalid signature length");
        assembly{
            r := mload(add(sign, 32))
            s := mload(add(sign, 64))
            v := byte(0, mload(add(sign, 96)))
        }
    }

}
