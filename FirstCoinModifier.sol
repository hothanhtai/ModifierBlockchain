pragma solidity >=0.7.0 <0.9.0;
contract Firstcoin {
    address public minter;
    mapping (address => uint) public balances;

    event sent(address from , address to, uint amount);

    modifier onlyMint{
        require(msg.sender == minter);
        _;
    }

    modifier checkMount(uint amount){
        require(amount < 1e60);
        _;
    }

    modifier checkBalance(uint amount){
        require(amount <= balances[minter], "Tai khoan khong du de thuc hien giao dich,Vui long nap them tien!");
        _;
    }

    constructor(){
        minter = msg.sender;
    }
    //Khoi tao so coin
    function mint(address receiver, uint amount)public onlyMint checkMount(amount){
        balances[receiver] += amount;
    }
    //Chuyen tien
    function send(address receiver, uint amount) public checkBalance(amount){
        balances[minter] -= amount;
        balances[receiver] += amount;
        emit sent(minter , receiver , amount);
    }
}