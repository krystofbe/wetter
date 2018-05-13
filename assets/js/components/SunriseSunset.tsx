import * as React from "react";
const sundown = require("sundown");

// Sunset today in Cluj-Napoca, Romania
interface Props {
  latitude: number;
  longitude: number;
}
interface State {
  sunrise: string;
  sunset: string;
}

export default class SunriseSunset extends React.PureComponent<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = { sunrise: "", sunset: "" };
  }
  componentDidMount() {
    const sundownInMuenster = sundown(
      new Date(),
      this.props.latitude,
      this.props.longitude
    );
    this.setState({
      sunrise: sundownInMuenster.sunrise.time + " Uhr",
      sunset: sundownInMuenster.sunset.time + " Uhr"
    });
  }
  render() {
    return (
      <span>
        <span className="badge badge-info mx-1">
          <i className="fa fa-angle-double-up mr-1" />
          {this.state.sunrise}
        </span>
        <span className="badge badge-warning mx-1">
          <i className="fa fa-angle-double-down mr-1" />
          {this.state.sunset}
        </span>
      </span>
    );
  }
}
