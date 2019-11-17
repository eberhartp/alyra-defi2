import React, { Component } from "react";

class Contract extends Component {
    constructor(props) {
        super(props);
        this.state = {
            marketplace: props.marketplace,
            contractId: props.contractId,
            contractDetails: null
        };
    }

    async componentDidMount() {
        const { marketplace, contractId } = this.state;

        const contractDetails = await marketplace.methods.getContractDetails(contractId).call();

        this.setState({
            contractDetails: contractDetails
        });
    }

    render() {
        const { contractId, contractDetails } = this.state;
        return (
            <li className="ContractItem">
                {contractId}
                <textarea value={JSON.stringify(contractDetails, null, 2)}></textarea>
            </li>
        );
    }
}

export default Contract;