// SPDX-License-Identifier: LGPL-3.0-only
pragma solidity ^0.8.6;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract SekerFactory is ERC721URIStorage, AccessControl {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    bytes32 public constant MINTER_ROLE = keccak256("Minter");

    /// @dev Restricted to members of the admin role.
    modifier onlyAdmin() {
        require(isAdmin(msg.sender), "Restricted to admins");
        _;
    }

    /// @dev Restricted to members of the user role.
    modifier onlyMinter() {
        require(isMinter(msg.sender), "Restricted to minters");
        _;
    }

    constructor() ERC721("Seker Factory", "SEKER") {
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _setRoleAdmin(MINTER_ROLE, DEFAULT_ADMIN_ROLE);
    }

    function mint(string memory _tokenURI) public onlyMinter {
        uint256 newNFT = _tokenIds.current();
        _safeMint(msg.sender, newNFT);
        _setTokenURI(newNFT, _tokenURI);
        _tokenIds.increment();
    }

    /// @dev Add an account to the user role. Restricted to admins.
    function addMinter(address account) public virtual onlyAdmin {
        grantRole(MINTER_ROLE, account);
    }

    /// @dev Return `true` if the account belongs to the admin role.
    function isAdmin(address account) public view virtual returns (bool) {
        return hasRole(DEFAULT_ADMIN_ROLE, account);
    }

    /// @dev Return `true` if the account belongs to the user role.
    function isMinter(address account) public view virtual returns (bool) {
        return hasRole(MINTER_ROLE, account);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(ERC721, AccessControl)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
