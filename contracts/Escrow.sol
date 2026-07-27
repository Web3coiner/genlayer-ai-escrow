// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Escrow {
    event Deposited(address indexed buyer, uint256 amount);
    event FundsReleased(address indexed seller, uint256 amount);
    event BuyerRefunded(address indexed buyer, uint256 amount);
    event DisputeOpened(address indexed buyer);
    event BuyerEvidenceSubmitted(string evidence);
    event SellerEvidenceSubmitted(string evidence);
    event AIDecisionRecorded(string decision);
    address public buyer;
    address public seller;

    enum Status {
        Created,
        Funded,
        Released,
        Refunded
    }

    Status public status;
    string public buyerEvidence;
    string public sellerEvidence;

    bool public disputeOpened;

    string public aiDecision;
    constructor(address _seller) {
        buyer = msg.sender;
        seller = _seller;
        status = Status.Created;
    }

    function deposit() external payable {
        require(msg.sender == buyer, "Only buyer");
        require(status == Status.Created, "Already funded");
        require(msg.value > 0, "No ETH sent");

        status = Status.Funded;
        emit Deposited(msg.sender, msg.value);
    }

    function releaseFunds() external {
        require(msg.sender == buyer, "Only buyer");
        require(status == Status.Funded, "Not funded");

        status = Status.Released;
        emit FundsReleased(seller, address(this).balance);
        payable(seller).transfer(address(this).balance);
    }

    function refundBuyer() external {
        require(msg.sender == seller, "Only seller");
        require(status == Status.Funded, "Not funded");

        status = Status.Refunded;
        emit BuyerRefunded(buyer, address(this).balance);
        payable(buyer).transfer(address(this).balance);
    }
    function openDispute() external {
        require(msg.sender == buyer, "Only buyer");
        require(status == Status.Funded, "Contract not funded");

        disputeOpened = true;

        emit DisputeOpened(msg.sender);
    }

    function submitBuyerEvidence(string memory evidence) external {
        require(msg.sender == buyer, "Only buyer");

        buyerEvidence = evidence;

        emit BuyerEvidenceSubmitted(evidence);
    }

    function submitSellerEvidence(string memory evidence) external {
        require(msg.sender == seller, "Only seller");

        sellerEvidence = evidence;

        emit SellerEvidenceSubmitted(evidence);
    }

    function recordAIDecision(string memory decision) external {
        aiDecision = decision;

        emit AIDecisionRecorded(decision);
    }
}
