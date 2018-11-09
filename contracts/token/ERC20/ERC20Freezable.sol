pragma solidity ^0.4.24;

import "./ERC20.sol";
import "../../lifecycle/Freezable.sol";

/**
 * @title Pausable token
 * @dev ERC20 modified with freezable transfers.
 **/
contract ERC20Freezable is ERC20, Freezable {

  function transfer(
    address to,
    uint256 value
  ) public whenNotFreezed returns (bool) {
    return super.transfer(to, value);
  }

  function transferFrom(
    address from,
    address to,
    uint256 value
  ) public whenNotFreezed returns (bool) {
    return super.transferFrom(from, to, value);
  }

  function approve(
    address spender,
    uint256 value
  ) public whenNotFreezed returns (bool) {
    return super.approve(spender, value);
  }

  function increaseAllowance(
    address spender,
    uint addedValue
  ) public whenNotFreezed returns (bool success) {
    return super.increaseAllowance(spender, addedValue);
  }

  function decreaseAllowance(
    address spender,
    uint subtractedValue
  ) public whenNotFreezed returns (bool success) {
    return super.decreaseAllowance(spender, subtractedValue);
  }
}
