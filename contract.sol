//SuperOracle contract
contract SuperOracle
{
	struct Bet {
		address betAddress;
		uint amount;
		bool bet;
	}
	
	mapping (uint => Bet) bets;
	uint size = 0;
	address oracle = 0xb0dcdc575ef06dc30aaea069d8043c9d463c931c;
	
	function SuperOracle () {
	
	}

	
	function makeBet (bool bet) returns (uint) {
		if (msg.value <= 0) {
			return 0;
		}
		Bet newBet = bets[++size];		
		
		newBet.betAddress = msg.sender;
		newBet.amount = msg.value;
		newBet.bet = bet;
		return msg.value;
	}
	
	function run (bool result) returns (uint) {
		if (oracle != msg.sender) return;		
		
		uint totalAmount;
		uint winnersAmount;
		for (var i = 0; i < size; i++) {
			totalAmount += bets[i].amount;
			if (bets[i].bet == result) {
				winnersAmount++;
			}
		}
		uint winnerResult = totalAmount / winnersAmount;
		for (i = 0; i < size; i++) {
			if (bets[i].bet == result) {
				bets[i].betAddress.send(winnerResult);
			}
		}
		//msg.sender.send(1);
		return winnerResult;
	}
}
