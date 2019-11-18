import React, { Component } from "react";
import Marketplace from "./contracts/Marketplace.json";
import Contract from "./DemandItem";

class DemandList extends Component {
    constructor(props) {
        super(props);
        this.state = {
            web3: props.web3,
            account: props.account,
            marketplace: null,
            nbDemands: 0
        };
    }

    async componentDidMount() {
        const networkId = await this.state.web3.eth.net.getId();
        const networkData = Marketplace.networks[networkId];

        if (networkData) {
            const marketplace = new this.state.web3.eth.Contract(Marketplace.abi, networkData.address);
            const nbDemands = parseInt(await marketplace.methods.getNbDemands().call());
            this.setState({
                marketplace: marketplace,
                nbDemands: nbDemands
            });
        } else {
            window.alert("Marketplace Contract not deployed to detected network");
        }
    }

    render() {
        const { marketplace, nbDemands } = this.state;
        return (
            <div className="Demands">
                <ul className="DemandsList">
                    {
                        [...Array(nbDemands).keys()].map(contractId => 
                            <DemandItem key={contractId.toString()} marketplace={marketplace} contractId={contractId}/>
                        )
                    }
                </ul>
            </div>
        );
    }
}

export default DemandList;