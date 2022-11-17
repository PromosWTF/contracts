[![NPM Package](https://img.shields.io/npm/v/@promos/contracts.svg)](https://www.npmjs.org/package/@promos/contracts)

### Installation

```console
$ npm i @promos/contracts
```

### Usage

Once installed, import and inherit the `Promos` contract
**Please, pay particular attention to comments for `mintPromos` function below**

```solidity
pragma solidity ^0.8.0;

import "@promos/contracts/Promos.sol";
import "erc721a/contracts/ERC721A.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ERC721 is ERC721A, Promos, Ownable {
    constructor() ERC721A("", "") Promos(owner()) {}

    /**
     * @dev 
     * After deployment use this function to set `promosProxyContract`. 
     * Mainnet - 0xA7296e3239Db13ACa886Fb130aE5Fe8f5A315721 
     * Goerli  - 0x90766204108309bf97b998E262D05aa1b00Bc35c
     */
    function setPromosProxyContract(address _promosProxyContract)
        external
        override
        onlyOwner
    {
        promosProxyContract = _promosProxyContract;
    }

    // Promos mint function. Use `OnlyPromos` modifier to restrict to Promos contract
    function mintPromos(address _to, uint256 _amount)
        external
        payable
        override
        OnlyPromos(_to)
    {
        // IMPORTANT!
        // Add custom logic here
        // Make sure to require certain conditions to be met(e.g. supply, max per wallet, etc.)

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
