pragma solidity 0.4.21;

import "zeppelin-solidity/contracts/math/SafeMath.sol";
import "./VotingToken.sol";


contract DAO {

    using SafeMath for uint;

    uint private _transactionFee;
    VotingToken private _votingToken;

    struct TXRequest {
        uint newFeeValue;
        uint votes;
        uint endTime;
        bool hasEnded;
    }

    TXRequest[] private _requests;

    function DAO(VotingToken voting) public {
        _transactionFee = 10;
        _votingToken = voting;
    }

    function createTXChangeRequest(uint newTXFee) public returns (uint) {
        require(newTXFee < 100);

        _requests.push(TXRequest({
            newFeeValue: newTXFee,
            votes: 0,
            endTime: now + 1 days,
            hasEnded: false
        }));

        return (_requests.length - 1);
    }

    function voteForTXRequest(uint requestID) public {
        require(requestID < _requests.length);
        TXRequest request = _requests[requestID];
        require(request.hasEnded == false);

        uint numberOfVotes = _votingToken.balanceOf(msg.sender);

        request.votes += numberOfVotes;
    }

    function applyRequest(uint requestID) public {

        require(_requests.length < requestID);
        TXRequest request = _requests[requestID];
        require(request.hasEnded == false);
        require(request.votes > (_votingToken.totalSupply() / 2));

        _transactionFee = request.newFeeValue;
    }

    function calculateTxFee(uint amount) public view returns (uint) {
        return amount.div(100).mul(_transactionFee);
    }
}
