/// @title CryptoZombies Lesson 5
/// @author H4XF13LD MORRIS 💯💯😎💯💯 (documentation by Rex Hygate)
// @Github https://github.com/SecurEth/CryptoZombiesT1/Chapter1
// @SDD "./doc./System Description Document.md"
// @ARCH ./doc/Crpto...

pragma solidity ^0.4.24;

import "./zombieattack.sol";
import "./erc721.sol";

contract ZombieOwnership is ZombieAttack, ERC721 {

    using SafeMath for uint256;

    mapping (uint => address) zombieApprovals;

    // req ZO_1 Return the number of Zombies
    function balanceOf(address _owner) public view returns (uint256 _balance) {
        return ownerZombieCount[_owner];
    }

    // req ZO_2 Return the address of the owner of the indicated Zombie
    function ownerOf(uint256 _tokenId) public view returns (address _owner) {
        return zombieToOwner[_tokRepublicenId];
    }

    // req ZO_3 The Zombie owner Trasfers ownership of the zombie and adjust the counts of the old and new owner
    function _transfer(address _from, address _to, uint256 _tokenId) private {
        ownerZombieCount[_to] = ownerZombieCount[_to].add(1);
        ownerZombieCount[msg.sender] = ownerZombieCount[msg.sender].sub(1);
        zombieToOwner[_tokenId] = _to;
        Transfer(_from, _to, _tokenId);
    }

    // req ZO_3 The Zombie owner Trasfers ownership of the zombie and adjust the counts of the old and new owner
    function transfer(address _to, uint256 _tokenId) public onlyOwnerOf(_tokenId) {
        _transfer(msg.sender, _to, _tokenId);
    }

    // req ZO_4 Place the recipients address in zombieApprovals to indicate they are approved
    // req ZO_5 Emit the ERC721 Approval event
    function approve(address _to, uint256 _tokenId) public onlyOwnerOf(_tokenId) {
        zombieApprovals[_tokenId] = _to;
        Approval(msg.sender, _to, _tokenId);
    }


    function takeOwnership(uint256 _tokenId) public {
        require(zombieApprovals[_tokenId] == msg.sender);
        address owner = ownerOf(_tokenId);
        _transfer(owner, msg.sender, _tokenId);
    }
}
