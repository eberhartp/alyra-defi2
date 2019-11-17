import React, { Component } from "react";
import Marketplace from "./contracts/Marketplace.json";
import Contract from "./Contract";

class Contracts extends Component {
    constructor(props) {
        super(props);
        this.state = {
            web3: props.web3,
            account: props.account,
            marketplace: null,
            nbContracts: 0
        };
    }

    async componentDidMount() {
        const networkId = await this.state.web3.eth.net.getId();
        const networkData = Marketplace.networks[networkId];

        if (networkData) {
            const marketplace = new this.state.web3.eth.Contract(Marketplace.abi, networkData.address);
            const nbContracts = parseInt(await marketplace.methods.getNbContracts().call());
            this.setState({
                marketplace: marketplace,
                nbContracts: nbContracts
            });
        } else {
            window.alert("Marketplace Contract not deployed to detected network");
        }
    }

    render() {
        const { marketplace, nbContracts } = this.state;
        return (
            <div className="Contracts">
                <ul className="ContractsList">
                    {
                        [...Array(nbContracts).keys()].map(contractId => 
                            <Contract key={contractId.toString()} marketplace={marketplace} contractId={contractId}/>
                        )
                    }
                </ul>
            </div>
        );
    }
}

export default Contracts;