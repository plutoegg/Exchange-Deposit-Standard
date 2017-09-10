pragma solidity ^0.4.8;

import "./ERC20Interface.sol";
import "./strings.sol"; // https://github.com/Arachnid/solidity-stringutils

contract DepositSink {
    using strings for *;

address owner;
address hotWallet;

modifier onlyOwner() {
  if (msg.sender != owner) {
    throw;
  }
  _;
}

function DepositSink(address _hotWallet) {
  owner = msg.sender;
  hotWallet = _hotWallet;
}

function sendDeposit(string paymentReference) payable returns (bool){
  // Check to match whichever payment reference schema is used
  // for example here string must begin with 'bitfinex' and be 12 chars long
  var s = paymentReference.toSlice();
  if (s.startsWith("bitfinex".toSlice()) && s.len() == 12) {
    DepositReceived(msg.sender, paymentReference, msg.value);
    hotWallet.transfer(msg.value);
    return true;
  }
  else {
    BadDepositReceived(msg.sender, paymentReference, msg.value);
    msg.sender.transfer(msg.value);
    return false;
  }
}

function() payable {
  BadDepositReceived(msg.sender, "" , msg.value);
  msg.sender.transfer(msg.value);
}

// Methods to change owner and wallet

function transferOwnership(address newOwner) onlyOwner {
  if (newOwner != address(0)) {
    owner = newOwner;
  }
}

function changeWallet(address newWallet) onlyOwner {
  if (newWallet != address(0)) {
    hotWallet = newWallet;
  }
}

/// @notice This method can be used by the controller to extract mistakenly
///  sent tokens to this contract or stuck ether.
/// @param _token The address of the token contract that you want to recover
///  set to 0 in case you want to extract ether.
function claimTokens(address _token) public onlyOwner {

    if (_token == 0x0) {
        owner.transfer(this.balance);
        return;
    }

    ERC20Interface token = ERC20Interface(_token);
    uint256 balance = token.balanceOf(this);
    token.transfer(owner, balance);
    ClaimedTokens(_token, owner, balance);
}

event DepositReceived(address fromAddress, string paymentReference, uint256 amount);
event BadDepositReceived(address fromAddress, string paymentReference, uint256 amount);
event ClaimedTokens(address token, address owner, uint256 balance);

}
