// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./.deps/ERC721.sol";

contract NFT is ERC721 {
    address public owner;
    uint256 public currentTokenId;
    uint256 public gasLimit;
    uint256 public gasPrice;

    struct TokenMetaData {
        string name;
        //bad names. Should be imageCID and audioCID
        string imageURI;
        string audioURI;
        address owner;
    }

    /* ToDo: Create and emit event */

    mapping(uint256 => TokenMetaData) public tokenMetaData;
    mapping(address => uint256[]) public ownedTokens;

    constructor(
        string memory _name,
        string memory _symbol
    ) ERC721(_name, _symbol) {
        owner = msg.sender;
    }

    function setGasParameters(
        uint256 _gasLimit,
        uint256 _gasPrice
    ) public onlyOwner {
        gasLimit = _gasLimit;
        gasPrice = _gasPrice;
    }

    function mintTo(
        string memory _name,
        string memory _imageURI,
        string memory _audioURI
    ) public payable returns (uint256) {
        require(msg.value >= gasLimit * gasPrice, "Insufficient gas fee");
        uint256 newItemId = ++currentTokenId;
        _safeMint(msg.sender, newItemId);
        tokenMetaData[newItemId] = TokenMetaData(
            _name,
            _imageURI,
            _audioURI,
            msg.sender
        );

        ownedTokens[msg.sender].push(newItemId);
        //ToDo : emit event

        if (msg.value > gasLimit * gasPrice) {
            payable(msg.sender).transfer(msg.value - gasLimit * gasPrice);
        }

        return newItemId;
    }

    function tokenURI(
        uint256 id
    ) public view virtual override returns (string memory) {
        require(_exists(id), "URI Query for nonexistent token");
        TokenMetaData memory metadata = tokenMetaData[id];

        return
            string(
                abi.encodePacked(
                    '{"address": "',
                    addressToString(metadata.owner),
                    '", ',
                    '"name": "',
                    metadata.name,
                    '", ',
                    '"image": "',
                    metadata.imageURI,
                    '", ',
                    '"audio": "',
                    metadata.audioURI,
                    '"}'
                )
            );
    }

    function getOwnedTokenIDs(
        address ownerAddress
    ) public view returns (uint256[] memory) {
        return ownedTokens[ownerAddress];
    }

    function addressToString(
        address _addr
    ) public pure returns (string memory) {
        bytes32 value = bytes32(uint256(uint160(_addr)));
        bytes memory alphabet = "0123456789abcdef";

        bytes memory str = new bytes(42);
        str[0] = "0";
        str[1] = "x";
        for (uint i = 0; i < 20; i++) {
            uint8 byteValue = uint8(value[i + 12]);
            str[2 + i * 2] = alphabet[byteValue >> 4];
            str[3 + i * 2] = alphabet[byteValue & 0x0f];
        }
        return string(str);
    }

    function _exists(uint256 id) internal view returns (bool) {
        return tokenMetaData[id].owner != address(0);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }
}
