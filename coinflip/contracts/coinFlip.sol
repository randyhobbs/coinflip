import "./Ownable.sol";
pragma solidity 0.5.8;

contract coinFlip is Ownable{

uint public flipBalance = 0;
uint public contractBalance = 0;
uint public payout;
uint public totalInvestment;

event flipResult(uint payout, string flip_result);


function random() private view returns(uint) {
  return now % 2;
  }

  function flipAndPay(uint guess) public payable returns(uint, string memory){
        require (msg.value >= 1, "Minimum bet is .000000000000000001 ETH");
        require(guess == 0 || guess == 1, "Choice must be heads or tails");
        flipBalance = 0;
        flipBalance += msg.value;
        contractBalance += msg.value;
        address payable player = msg.sender;
        uint flip;
        string memory flip_result;



        require(contractBalance >= payout, "Sorry, we don't have that amount");

        flip = random();
        flip_result = getResult(flip);

        if(flip == guess){
            payout = flipBalance * 2;
            player.transfer(payout);
            contractBalance -= payout;
            emit flipResult(payout, flip_result);

        }

        else{
            payout = -flipBalance;
            emit flipResult(payout, flip_result);
        }

  }

  function getResult(uint flip) private pure returns(string memory){
    string memory result;
    if(flip == 0){
      result = "heads";
    }
    else{
      result = "tails";
    }
    return result;
  }


     function withdrawProfit() public onlyOwner returns(uint) {
       require(contractBalance > totalInvestment);
       uint toTransfer = contractBalance - totalInvestment;
       contractBalance = totalInvestment;
       msg.sender.transfer(toTransfer);
       return toTransfer;
}

    function withdrawAll() public onlyOwner{
        uint toTransfer = contractBalance;
        contractBalance = 0;
        msg.sender.transfer(toTransfer);

    }

    function getContractBalance () public view returns (uint){
      return address(this).balance;
  }

    function fundContract() public payable{
      totalInvestment += msg.value;
      contractBalance += msg.value;
    }

}
