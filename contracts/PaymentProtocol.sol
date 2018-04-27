pragma solidity 0.4.21;

import "./DAO.sol";


contract PaymentProtocol {

    DAO private _dao;

    mapping (address => uint) private _outstanding;

    function PaymentProtocol(DAO dao) public {
        _dao = dao;
    }

    function pay(address to) public payable {

        uint paidAmount = msg.value;
        uint txFee = _dao.calculateTxFee(paidAmount);
        _outstanding[address(_dao)] = txFee;
        _outstanding[to] = (paidAmount - txFee);
    }

    function claim() public {
        require(_outstanding[msg.sender] > 0);
        msg.sender.send(_outstanding[msg.sender]);
    }

}
