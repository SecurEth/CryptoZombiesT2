pragma solidity >=0.4.0 <0.6.0;

/// @title CryptoZombies Testing Support Code
/// @author Rex Hygate 
// @Github https://github.com/SecurEth/CryptoZombiesT2/Lesson3
// @SDD "./doc./System Description Document.md"
// @ARCH ./doc/architecure.md

import "./ownable.sol";

contract TestingSupportCode is Ownable {
    
    event KittieAddr(address kittieToOwner);

    struct Kittie {
        bool isGestating;
        bool isReady;
        uint256 cooldownIndex;
        uint256 nextActionAt;
        uint256 siringWithId;
        uint256 birthTime;
        uint256 matronId;
        uint256 sireId;
        uint256 generation;
        uint256 genes;
    }

    Kittie[] public kitties;

    mapping (uint => address) public kittieToOwner;

    function createKittie () public {
        uint kid = kitties.push(Kittie(
            true, // isGestating
            true, // isReady
            5, // cooldownIndex
            7, // nextActionAt
            9, // siringWithId
            11, // birthTime
            13, // matronId
            15, // sireId
            17, // generation
            21 // genes
        )) - 1;
        kittieToOwner[kid] = msg.sender;
        emit KittieAddr(kittieToOwner[kid]);
    }

}