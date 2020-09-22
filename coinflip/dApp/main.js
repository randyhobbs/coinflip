var web3 = new Web3(Web3.givenProvider);
var contractInstance;

$(document).ready(function() {
    window.ethereum.enable().then(function(accounts){
      contractInstance = new web3.eth.Contract(abi, "0xC67B373244bD2327e8eE54e750E4CfB9c80a1894", {from: accounts[0]});
      console.log(contractInstance);
});
  $("#flip_button").click(sendBet)
});

function sendBet(){
var playerChoice = $("#sides").val();
require(playerChoice == "heads" || playerChoice == "tails", "Choice must be heads or tails");

var guess;
if(playerChoice == "heads"){
  guess = 0;
}
else{
  guess = 1;
}

var bet = $("#bet_amount").val();

var config = {
  value: web3.utils.toWei(bet, "ether")
}

  };

contractInstance.methods.flipAndPay(guess).send(config).then(function(res){

  .on("transactionHash", function(hash){
    console.log(hash);
  })
  .on("confirmation", function(confirmationNr){
    console.log(confirmationNr);
  })
  .on("receipt", function(receipt){
    console.log(receipt);
    alert("Done");
  })
      $("#result_output").text(res.headsOrTails);
      $("#payout_output").text(res.payout);

})

}
