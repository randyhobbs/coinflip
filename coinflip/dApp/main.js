var web3 = new Web3(Web3.givenProvider);
var contractInstance;
var user;

$(document).ready(function() {
    window.ethereum.enable().then(function(accounts){
      contractInstance = new web3.eth.Contract(abi, "0x49eFe51b8C23760e50ea389c5b2081a9328bE12b", {from: accounts[0]});
      user = accounts[0];
      console.log(contractInstance);
});
  $("#flip_button").click(sendBet)
});

function sendBet(){
var bet = $("#bet_amount").val();
var playerChoice = $("#sides").val();

var guess;
if(playerChoice == "heads"){
  guess = 0;
}
else{
  guess = 1;
}

var config = {
  from: user,
  value: web3.utils.toWei(bet, "ether")
}


contractInstance.methods.flipAndPay(guess).send(config)

.on("transactionHash", function(hash){
    console.log(hash);
  })
  .on("confirmation", function(confirmationNr){
    console.log(confirmationNr);
  })
  .on("receipt", function(receipt){
    console.log(receipt)})
    .then(function(res){
    $("#result_output").text(res.flip_result);
    $("#payout_output").text(res.payout);
  });

}
