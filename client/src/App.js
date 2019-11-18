import React, { Component } from "react";
import Web3 from "web3";
import "./App.css";
import DemandList from "./DemandList";

class App extends Component {
    constructor(props) {
        super(props);
        this.state = {
            web3: null,
            account: ""
        };
    }

    async componentDidMount() {
        await this.loadWeb3();
        await this.loadBlockchainData();
    }

    async loadWeb3() {
        if (window.ethereum) {
            window.web3 = new Web3(window.ethereum);
            await window.ethereum.enable();
        } else if (window.web3) {
            window.web3 = new Web3(window.web3.currentProvider);
        } else {
            window.alert("Non-Ethereum based browser. You should consider trying Metamask!")
        }
    }

    async loadBlockchainData() {
        const web3 = window.web3;

        const accounts = await web3.eth.getAccounts();
        this.setState({
            account: accounts[0],
            web3: web3
        });
    }

    render() {
        const { web3, account } = this.state;
        if (web3 === null)
            return null;
        return (
            <div className="App">
                <DemandList web3={web3} account={account} />
            </div>
        );
    }
}

export default App;