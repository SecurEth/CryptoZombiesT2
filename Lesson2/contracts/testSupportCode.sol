pragma solidity >=0.4.0 <0.6.0;

/// @title CryptoZombies Testing Support Code
/// @author Rex Hygate 
// @Github https://github.com/SecurEth/CryptoZombiesT2/Lesson3
// @SDD "./doc./System Description Document.md"
// @ARCH ./doc/architecure.md

//import "./ownable.sol";

contract TestSupportCode {
    
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

    function getKitty(uint256 _id) external view returns (
        bool isGestating,
        bool isReady,
        uint256 cooldownIndex,
        uint256 nextActionAt,
        uint256 siringWithId,
        uint256 birthTime,
        uint256 matronId,
        uint256 sireId,
        uint256 generation,
        uint256 genes)
    {
        isGestating = kitties[_id].isGestating;
        isReady = kitties[_id].isReady;
        cooldownIndex = kitties[_id].cooldownIndex;
        nextActionAt = kitties[_id].nextActionAt;
        siringWithId = kitties[_id].siringWithId;
        birthTime = kitties[_id].birthTime;
        matronId = kitties[_id].matronId;
        sireId = kitties[_id].sireId;
        generation = kitties[_id].generation;
        genes = kitties[_id].genes;
        return (
            isGestating,
            isReady,
            cooldownIndex,
            nextActionAt,
            siringWithId,
            birthTime,
            matronId,
            sireId,
            generation,
            genes       
        );
    }

}