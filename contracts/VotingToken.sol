pragma solidity 0.4.21;

import "zeppelin-solidity/contracts/token/ERC20/StandardToken.sol";


contract VotingToken is StandardToken {

    string public symbol = "VTKN";
    string public name = "VotingToken";
    uint8 public decimals = 18;

    function VotingToken() public {
        balances[msg.sender] = 1000000 * (10 ** uint256(decimals));
        totalSupply_ = 1000000 * (10 ** uint256(decimals));
    }

}
