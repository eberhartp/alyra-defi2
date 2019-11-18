import React, { Component } from "react";

class DemandItem extends Component {
    constructor(props) {
        super(props);
        this.state = {
            marketplace: props.marketplace,
            demandId: props.demandId,
            demandDetails: null
        };
    }

    async componentDidMount() {
        const { marketplace, demandId } = this.state;

        const demandDetails = await marketplace.methods.getDemandDetails(demandId).call();

        this.setState({
            demandDetails: demandDetails
        });
    }

    render() {
        const { demandId, demandDetails } = this.state;
        return (
            <li className="DemandItem">
                {demandId}
                <textarea value={JSON.stringify(demandDetails, null, 2)}></textarea>
            </li>
        );
    }
}

export default DemandItem;