var DAO = artifacts.require("./DAO.sol");
var PaymentProtocol = artifacts.require("./PaymentProtocol.sol");
var VotingToken = artifacts.require("./VotingToken.sol");

module.exports = function(deployer) {

    deployer.deploy(VotingToken)
        .then(() => VotingToken.deployed())
        .then(() => deployer.deploy(DAO, VotingToken.address))
        .then(() => DAO.deployed())
        .then(() => deployer.deploy(PaymentProtocol, DAO.address))
        .then(() => PaymentProtocol.deployed());



}
