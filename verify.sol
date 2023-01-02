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

/*hash = "0xcf36ac4f97dc10d91fc2cbb20d718e94a8cbfe0f82eaedc6a4aa38946fb797cd" 
Sign message hash 
    Signature will be :: 0x993dab3dd91f5c6dc28e17439be475478f5635c92a56e17e82349d3fb2f166196f466c0b4e0c 146f285204f0dcb13e5ae67bc33f4b888ec32dfe0a063e8f3f781b 

Verify signature 
signer = 0xB273216C05A8c0D4F0a4Dd0d7Bae1D2EfFE636dd 
to = 0x14723A09ACff6D2A60DcdF7aA4AFf308FDDC160C 
amount = 123 
message = "coffee and donuts" 
nonce = 1 
signature =   0x993dab3dd91f5c6dc28e17439be475478f5635c92a56e17e82349d3fb2f166196f466c0b4e0c 146f285204f0dcb13e5ae67bc33f4b888ec32dfe0a063e8f3f781b*/
