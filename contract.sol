//Sample contract
contract SuperOracle
{
	struct Bet {
		address betAddress;
		uint amount;
		bool bet;
	}
	
	mapping (uint => Bet) bets;
	uint size;
	address oracle = 0x004f71832d8a74485841f56e31d5ec18ef3bf470;
	
	function SuperOracle () {
	
	}
	
	function makeBet (bool bet) {
		if (msg.value <= 0) return;
		Bet newBet = bets[++size];		
	
		newBet.betAddress = msg.sender;
		newBet.amount = msg.value;
		newBet.bet = bet;
	}
	
	function run (bool result) {
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
		msg.sender.send(1);
	}
}
