pragma solidity ^0.4.24;

import "../Roles.sol";

contract FreezerRole {
  using Roles for Roles.Role;

  event FreezerAdded(address indexed account);
  event FreezerRemoved(address indexed account);

  Roles.Role private freezers;

  constructor() internal {
    _addFreezer(msg.sender);
  }

  modifier onlyFreezer() {
    require(isFreezer(msg.sender));
    _;
  }

  function isFreezer(address account) public view returns (bool) {
    return freezers.has(account);
  }

  function addFreezer(address account) public onlyFreezer {
    _addFreezer(account);
  }

  function renounceFreezer() public {
    _removeFreezer(msg.sender);
  }

  function _addFreezer(address account) internal {
    freezers.add(account);
    emit FreezerAdded(account);
  }

  function _removeFreezer(address account) internal {
    freezers.remove(account);
    emit FreezerRemoved(account);
  }
}
