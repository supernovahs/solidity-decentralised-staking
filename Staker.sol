pragma solidity 0.8.4;


import "./ExampleExternalContract.sol";

contract Staker {

  ExampleExternalContract public exampleExternalContract;
  mapping(address=>uint) public balances;
  uint256 public constant threshold= 1 ether;
  uint256 public deadline= block.timestamp + 100 seconds;
  event Stake(address,uint256);
  bool public openForWithdraw;
  
  
  constructor(address exampleExternalContractAddress) public {
      exampleExternalContract = ExampleExternalContract(exampleExternalContractAddress);
  }
  function stake() public  payable{
    balances[msg.sender] ++;
    emit Stake(msg.sender,msg.value);
  } 
  function withdraw(address payable) public {
    
    openForWithdraw= true;
  }

  function execute() public {
    require(block.timestamp>deadline);
    if (address(this).balance >= threshold){
      exampleExternalContract.complete{value:address(this).balance}();

    }
    else if (address(this).balance <threshold) {
      bool openForWithdraw= true; 

    }


    }
    function timeLeft() public view returns(uint) {
      return (deadline- block.timestamp);
  }



  // Collect funds in a payable `stake()` function and track individual `balances` with a mapping:
  //  ( make sure to add a `Stake(address,uint256)` event and emit it for the frontend <List/> display )


  // After some `deadline` allow anyone to call an `execute()` function
  //  It should either call `exampleExternalContract.complete{value: address(this).balance}()` to send all the value


  // if the `threshold` was not met, allow everyone to call a `withdraw()` function


  // Add a `timeLeft()` view function that returns the time left before the deadline for the frontend


  // Add the `receive()` special function that receives eth and calls stake()


}
