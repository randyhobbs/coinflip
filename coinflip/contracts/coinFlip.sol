import "./Ownable.sol";
pragma solidity 0.5.8;

contract coinFlip is Ownable{

uint public flipBalance = 0;
uint public contractBalance = 100000000000000000000;
uint public payout;
string public headsOrTails;

function random() private view returns (uint) {
  return now % 2;
  }

function flip() public view returns (string memory) {
    uint randomResult = random();
    string memory coinResult;

  if(randomResult == 0){
    coinResult = "heads";
  }

  else if (randomResult == 1){
    coinResult = "tails";
  }
  return coinResult;
  }

  function flipAndPay(string memory guess) public payable returns(uint, string memory){
        require (msg.value >= 1);
        flipBalance = 0;
        flipBalance += msg.value;
        contractBalance += msg.value;
        address payable player = msg.sender;

        require(contractBalance >= payout, "Sorry, we don't have that amount");

        headsOrTails = flip();

        if(keccak256(abi.encodePacked(headsOrTails)) == keccak256(abi.encodePacked(guess))){
            payout = flipBalance * 2;
            player.transfer(payout);
            contractBalance -= payout;
            return(payout, headsOrTails);

        }

        else{
            payout = -flipBalance;
            return(payout, headsOrTails);
        }

  }


     function withdrawProfit() public onlyOwner returns(uint) {
       require(contractBalance > 100000000000000000000);
       uint toTransfer = contractBalance - 100000000000000000000;
       contractBalance = 100000000000000000000;
       msg.sender.transfer(toTransfer);
       return toTransfer;
}

    function withdrawAll() public onlyOwner{
        uint toTransfer = contractBalance;
        contractBalance = 0;
        msg.sender.transfer(toTransfer);

    }

}
