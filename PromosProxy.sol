// SPDX-License-Identifier: MIT
// Creator: promos.wtf

import "@openzeppelin/contracts/access/Ownable.sol";

contract PromosProxy is Ownable {
    address public promosMintAddress;

    function setPromosMintAddress(address _promosMintAddress)
        external
        onlyOwner
    {
        promosMintAddress = _promosMintAddress;
    }
}
