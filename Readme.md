[![NPM Package](https://img.shields.io/npm/v/@promos/contracts.svg)](https://www.npmjs.org/package/@promos/contracts)

### Installation

```console
$ npm i @promos/contracts
```

### Usage

Once installed, import and inherit the `Promos` contract

```solidity
pragma solidity ^0.8.0;

import "@promos/contracts/Promos.sol";
import "erc721a/contracts/ERC721A.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ERC721 is ERC721A, Promos, Ownable {
    constructor(address _promosMintContract)
        ERC721A("NAME", "SYMBOL")
        Promos(_promosMintContract)
    {}

    function setPromosMintContract(address _promosMintContract)
        external
        override
        onlyOwner
    {
        promosMintContract = _promosMintContract;
    }

    // Promos mint function. Use `OnlyPromos` modifier to restrict to Promos contract
    function mintPromos(address _to, uint256 _amount)
        external
        payable
        override
        OnlyPromos(_to)
    {
        // Your custom logic here

        // IMPORTANT! 
        // Avoid using msg.sender and use _to argument instead
        _safeMint(_to, _amount);
    }

    // Required to support `IPromos.sol`
    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(ERC721A, Promos)
        returns (bool)
    {
        return
            Promos.supportsInterface(interfaceId) ||
            super.supportsInterface(interfaceId);
    }
}
```
