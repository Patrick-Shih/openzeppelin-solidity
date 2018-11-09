pragma solidity ^0.4.24;

import "../access/roles/FreezerRole.sol";

/**
 * @title Freezable
 * @dev Base contract which allows children to implement an emergency account freeze mechanism.
 */
contract Freezable is FreezerRole {
  event Freezed(address freezer, address freezee);
  event Unfreezed(address freezer, address freezee);

  mapping (address => bool) _freezed;

  /**
   * @param account The account to query.
   * @return true if the account is freezed, false otherwise.
   */
  function freezed(address account) public view returns(bool) {
    return _freezed[account];
  }

  /**
   * @dev Modifier to make a function callable only when the account is not freezed.
   */
  modifier whenNotFreezed() {
    require(!_freezed[msg.sender]);
    _;
  }

  /**
   * @dev Modifier to make a function callable only when the account is freezed.
   */
  modifier whenFreezed() {
    require(_freezed[msg.sender]);
    _;
  }

  /**
   * @dev called by the account with Freezer role to freeze other account include itself, triggers freezed state.
   * @param account The account to freeze.
   */
  function freeze(address account) public onlyFreezer whenNotFreezed {
    _freezed[account] = true;
    emit Freezed(msg.sender, account);
  }

  /**
   * @dev called by the account with Freezer role to unfreeze other account include itself, returns to unfreezed state.
   * @param account The account to freeze.
   */
  function unfreeze(address account) public onlyFreezer whenFreezed {
    _freezed[account] = false;
    emit Unfreezed(msg.sender, account);
  }
}
